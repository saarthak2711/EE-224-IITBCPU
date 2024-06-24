library ieee;
use ieee.std_logic_1164.all;

entity FSM is 
       port ( reset,clock,ALU_Z,Z_out : in std_logic;
		        PC_out,Mem_data_out,RF_D1,RF_D2,T1_out,T2_out,T3_out,IR_out,ALU_C,SE6_out,SE9_out,SFT_out : in std_logic_vector (15 downto 0);
				  S_MUX : in std_logic_vector (2 downto 0);
				  PC_write,M_write,RF_write,IR_write,T1_write,T2_write,T3_write,SC_MUX,Z_write,Z_in,O : out std_logic := '0';
				  PC_in,Mem_Add,Mem_Data_in,IR_in,T1_in,T2_in,T3_in,RF_D3,ALU_A,ALU_B : out std_logic_vector (15 downto 0);
				  RF_A1,RF_A2,RF_A3 : out std_logic_vector (2 downto 0);
				  state_vector : out std_logic_vector (4 downto 0));
end entity FSM;

architecture bhv of FSM is

type state is ( rst,s1,s2,s3,s4,s7,s8,s11,s14,s15,s20,s23,s24,s27,s28,s31); 
signal y_present, y_next: state:= rst ;				 
signal op_code : std_logic_vector(3 downto 0);

begin 

clock_proc : process (ALU_C,T3_out,IR_out,T1_out,T2_out,RF_D1,RF_D2,PC_out,Mem_data_out,clock,reset)
begin 

if ( rising_edge(clock)) then 
    if ( reset = '1') then 
	      y_present <= rst;
	 else 
	      y_present <= y_next;
	 end if;
end if;

end process clock_proc;

state_transition_proc : process(ALU_C,ALU_Z,T3_out,IR_out,T1_out,T2_out,RF_D1,RF_D2,PC_out,Mem_data_out,y_present,reset,clock)

begin 
     case y_present is 
	       when rst =>
			      y_next <= s1;  
			      state_vector <= "00000";    
			 when s1 =>
			         M_write <='0';
						PC_write <='1';
						IR_write <='1';
					   O <= '0'; 
					   RF_write <= '0';	-- control signals
						
			         Mem_Add <= PC_out;
                  IR_in <= Mem_data_out;					   
					   ALU_A <= PC_out;
					   ALU_B <= "0000000000000001";
					   PC_in <= ALU_C; -- signals
						state_vector <= "00001";
			         
						y_next <= s2;  -- state transition
			 when s2 =>
			         PC_write <= '0';
						IR_write <= '0';
					   M_write <= '0';
					   RF_write <= '0';	
						T1_write <= '1';
						T2_write <= '1';	-- control signals
						
			         RF_A1 <= IR_out (11 downto 9);
						RF_A2 <= IR_out (8 downto 6);
						T1_in <= RF_D1;
						T2_in <= RF_D2; -- signals
						
						op_code <= IR_out(15 downto 12); -- Operation Code
						state_vector <= "00010";
						
						-- State Transition for different values of Operation Code 
				      if(op_code ="0000" or op_code = "0010" or op_code = "0011" or op_code = "0100" or op_code = "0101" or op_code = "0110") then -- add sub mul and ora imp
						   y_next <= s3;
						elsif(op_code = "0001") then -- adi
						   y_next <= s7;
						elsif(op_code = "1000" or op_code = "1001") then -- lli lhi
						   y_next <= s11;
						elsif(op_code = "1010" or op_code = "1011") then -- lw sw
						   y_next <= s14;
						elsif(op_code = "1100") then --beq
					      y_next <= s23;
						elsif(op_code = "1101") then --jal
					      y_next <= s27;
						elsif(op_code = "1111") then --jlr
					      y_next <= s31;
						end if;	
						
			when s3 =>
			         M_write <= '0';
						PC_write <= '0';
						O <= '1';
						T1_write <= '0';
						T2_write <= '0';
						T3_write <= '1';
					   SC_MUX <= '0';	-- control signals
						
						ALU_A <= T1_out;
						ALU_B <= T2_out;
						T3_in <= ALU_C; -- signals
						state_vector <= "00011";
						
						y_next <=s4; -- state transition
		   when s4 =>
			         T3_write <= '0';
						RF_write <= '1'; -- control signals
						
						RF_D3 <= T3_out;
						RF_A3 <= S_MUX; -- signals
						state_vector <= "00100";
						
						y_next <=s1; -- state
		   when s7 =>
			         T1_write <= '0';
						T2_write <= '0';
			         T3_write <= '1'; -- control signals
						
						ALU_A <= T1_out;
			         ALU_B <= SE6_out;
						T3_in <= ALU_C; -- signals
						state_vector <= "00111";
						
						y_next <= s8; -- state transition
			when s8 =>
			         RF_write <='1';
						M_write <= '0';
						T3_write <= '0'; -- control signals
						
						RF_A3 <= IR_out(8 downto 6);
						RF_D3 <= T3_out; -- signals
						state_vector <= "01000";
						
						y_next <= s1;
			when s11 =>
		            T1_write <= '0';
					   T2_write <= '0';
					   T3_write <= '0'; 
					   RF_write <= '1'; -- control signals
						
						RF_A3 <= IR_out(11 downto 9);
						RF_D3 <= SFT_out; -- signals
						state_vector <= "01011";
						
						y_next <= s1; -- state transition
			when s14 =>
			         O <= '0';
						T1_write <= '0';
						T2_write <= '0';
						T3_write <= '1';
						M_write <= '0'; -- control signals
						
						ALU_A <= SE6_out;
						ALU_B <= T2_out;
						T3_in <= ALU_C; -- signals
						state_vector <= "01110";
						-- State transition based on load or store
						if (op_code = "1010") then --lw
						    y_next <= s15;
						elsif(op_code = "1011") then --sw
						    y_next <= s20;
						end if;
			when s15 =>
			         M_write <= '0';
						RF_write <= '0';
						T3_write <= '1';
					   SC_MUX <= '1';	-- control signals
						
				      Mem_Add <= T3_out;
				      T3_in <= Mem_data_out; -- signals
						state_vector <= "01111";
						
						y_next <= s4;
			when s20 =>
			         RF_write <='0';
						M_write <='1'; -- control signals
						
						Mem_Add <= T3_out;
						Mem_Data_in <= T1_out; -- signals 
						state_vector <= "10100";
						
						y_next <= s1; -- state transition
			when s23 => 
			         RF_write <='0';
						T3_write <= '0';
						T1_write <= '0';
						T2_write <= '0';
						M_write <= '0';
						O <= '0';
					   Z_write <= '1';	-- control signals
						
						ALU_A <= T1_out;
						ALU_B <= T2_out;
						Z_in <= ALU_Z; -- signals
						state_vector <= "10111";
						
						y_next <= s24; -- state transition
			when s24 =>
		            M_write <= '0';
				      O <= '0';
						Z_write<='0';
					   T3_write <= '0'; -- control signals
						ALU_A <= PC_out;
						ALU_B <= SE6_out;
						if (Z_out ='1') then 
						    PC_write <= '1';
							 PC_in <= ALU_C;
						end if; -- signals
						state_vector <= "11000";
						
					   y_next <= s1; -- state transition
		   when s27 => 
			         M_write <= '0';
						T3_write <= '0';
						T1_write <= '0';
						T2_write <= '0';
						RF_write <= '1'; -- control signals
						
						RF_A3 <= IR_out(11 downto 9);
						RF_D3 <= PC_out; -- signals
						state_vector <= "11011";
						
						y_next <= s28; -- state transition
		   when s28 => 
			         M_write <= '0';
						O <= '0';
						RF_write <= '0';
						PC_write <='1'; -- control variables
						
						ALU_A <= PC_out;
						ALU_B <= SE9_out;
						PC_in <= ALU_C; -- signals
						state_vector <= "11100";
						
						y_next <= s1; -- state transition
						
			when s31 => 
			         M_write <= '0';
						T3_write <= '0';
						T1_write <= '0';
						T2_write <= '0';
					   SC_MUX <= '1';
						PC_write <= '1';
						RF_write <= '1'; -- control signals
						
						RF_A3 <= S_MUX;
						RF_D3 <= PC_out;
						PC_in <= T2_out; -- signals
						state_vector <= "11111";
						
						y_next <= s1; -- state transition					
			   		         
	 end case;
end process state_transition_proc;
end bhv;
			 