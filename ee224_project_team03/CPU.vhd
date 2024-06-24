library ieee;
use ieee.std_logic_1164.all;

entity CPU is 
       port (PG_add,PG_data : in std_logic_vector (15 downto 0);
		       clk,reset,PG_write: in std_logic;
				 state : out std_logic_vector (4 downto 0);
				 IR : out std_logic_vector (15 downto 0);
				 ALU_out,Prog_counter,Test: out std_logic_vector (15 downto 0);
				 Z_flag: out std_logic);
end entity CPU;

architecture Struct of CPU is 

component memory is
port(	M_write:in std_logic;
		Mem_add:in std_logic_vector(15 downto 0);
		Mem_data_in:in std_logic_vector(15 downto 0);
		Mem_Data_out: out std_logic_vector(15 downto 0);
		clk:in std_logic);
end component;


component ALU is
    port (
        ALU_A: in std_logic_vector(15 downto 0);
        ALU_B: in std_logic_vector(15 downto 0);
        Sel: in std_logic_vector(3 downto 0);
        ALU_C: out std_logic_vector(15 downto 0);
		  ALU_Z: out std_logic
    );
end component;

component FSM is 
       port ( reset,clock,ALU_Z,Z_out : in std_logic;
		        PC_out,Mem_data_out,RF_D1,RF_D2,T1_out,T2_out,T3_out,IR_out,ALU_C,SE6_out,SE9_out,SFT_out : in std_logic_vector (15 downto 0);
				  S_MUX : in std_logic_vector (2 downto 0);
				  PC_write,M_write,RF_write,IR_write,T1_write,T2_write,T3_write,SC_MUX,Z_write,Z_in,O : out std_logic;
				  PC_in,Mem_Add,Mem_Data_in,IR_in,T1_in,T2_in,T3_in,RF_D3,ALU_A,ALU_B : out std_logic_vector (15 downto 0);
				  RF_A1,RF_A2,RF_A3 : out std_logic_vector (2 downto 0);
				  state_vector : out std_logic_vector (4 downto 0));
end component FSM;

component REG_16b is
  port (
    Clock, Enable, Reset: in std_logic; 
	 data_in : in std_logic_vector(15 downto 0);
    data_out: out std_logic_vector(15 downto 0) 
  );
end component;

component Reg_file is
  port (RF_A1, RF_A2, RF_A3: in std_logic_vector(2 downto 0);
		  RF_D1, RF_D2, PC_out: out std_logic_vector(15 downto 0);
		  RF_D3, PC_in: in std_logic_vector(15 downto 0);
		  RF_write,PC_write, clk, rst: in std_logic);
end component;


component MUX_2X1_4bits is 
 port(A,B : in std_logic_vector(3 downto 0);S : in std_logic;
         Y: out std_logic_vector(3 downto 0 ));
end component ;

component MUX_2X1_3bits is 
 port(A,B : in std_logic_vector(2 downto 0);S : in std_logic;
         Y: out std_logic_vector(2 downto 0 ));
end component ;

component DFK is
  port (
    d, reset, clk, en: in std_logic; 
    q: out std_logic 
  );
end component;

component SE_6 is 
 port(A : in std_logic_vector(5 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end component ;

component SE_9 is 
 port(A : in std_logic_vector(8 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end component ;

component SFT is 
 port(A : in std_logic_vector(7 downto 0);M: in std_logic_vector(3 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end component ;

component MUX_2X1_16bits is 
 port(A,B : in std_logic_vector(15 downto 0);S : in std_logic;
         Y: out std_logic_vector(15 downto 0 ));
end component ;

signal Mem_Add,Memory_Address,Memory_Data,Mem_Data_in,Mem_Data_out,RF_D1,RF_D2,RF_D3,ALU_A,ALU_B,ALU_C,IR_in,T1_in,T2_in,T3_in,T3_out,IR_out,T1_out,T2_out,SE6_out,SE9_out,SFT_out,PC_out,PC_in : std_logic_vector (15 downto 0);
signal Mem_write,M_write,IR_write,T1_write,T2_write,T3_write,RF_write,O,SC_MUX,ALU_Z,Z_OUT,Z_in,Z_write,PC_write : std_logic :='0';
signal RF_A1,RF_A2,RF_A3 : std_logic_vector (2 downto 0);
signal ALU_S : std_logic_vector(3 downto 0);
signal S_MUX : std_logic_vector(2 downto 0);
signal state_vector : std_logic_vector (4 downto 0);

begin 

Mem_write <= PG_write or M_write;

MUX1 : MUX_2x1_16bits port map( A => Mem_Add , B => PG_Add, S => PG_write, Y => Memory_Address); 
MUX2 : MUX_2x1_16bits port map( A => Mem_Data_in, B => PG_data, S => PG_write, Y => Memory_Data);

Mem : Memory port map ( M_write => Mem_write, Mem_Add => Memory_Address, Mem_Data_in => Memory_Data, Mem_Data_out => Mem_Data_out, clk => clk);

Register_File : Reg_File port map ( RF_A1,RF_A2,RF_A3,RF_D1,RF_D2,PC_out,RF_D3,PC_in,RF_write,PC_write,clk,reset);

Instruction_Register : Reg_16b port map (clock => clk, Enable => IR_write, reset => reset, data_in => IR_in, data_out => IR_out);

T1 : Reg_16b port map (clock => clk, Enable => T1_write, reset => reset, data_in => T1_in, data_out => T1_out);

T2 : Reg_16b port map (clock => clk, Enable => T2_write, reset => reset, data_in => T2_in, data_out => T2_out);

T3 : Reg_16b port map (clock => clk, Enable => T3_write, reset => reset, data_in => T3_in, data_out => T3_out);

ALU1 : ALU port map ( ALU_A => ALU_A, ALU_B => ALU_B, Sel => ALU_S, ALU_C => ALU_C, ALU_Z => ALU_Z);

Z_F: DFK port map (Z_in,reset,clk,Z_write,Z_OUT);

SE6 : SE_6 port map (IR_out(5 downto 0),SE6_OUT);
SE9 : SE_9 port map (IR_out(8 downto 0),SE9_OUT);

SFT1 : SFT port map (IR_out(7 downto 0),IR_out(15 downto 12),SFT_out);

StateMachine : FSM port map ( reset => reset, clock => clk, ALU_Z => ALU_Z, Z_out => Z_out, 
                              PC_out => PC_out, Mem_data_out => Mem_data_out,S_MUX => S_MUX, 
								      RF_D1 => RF_D1, RF_D2 => RF_D2, IR_out => IR_out,
								      T1_out => T1_out, T2_out => T2_out, T3_out => T3_out,
								      ALU_C => ALU_C, SE6_out => SE6_out, SE9_out => SE9_out, SFT_out => SFT_out, 
								  
								      PC_write => PC_write, M_write => M_write, RF_write => RF_write, IR_write => IR_write,O=>O, 
								      T1_write => T1_write, T2_write => T2_write, T3_write => T3_write,
								      SC_MUX => SC_MUX,Z_write => Z_write,Z_in => Z_in,
								      PC_in => PC_in, Mem_Add => Mem_Add, Mem_Data_in => Mem_Data_in,IR_in => IR_in,
								      T1_in => T1_in, T2_in => T2_in, T3_in => T3_in,
								      RF_D3 => RF_D3, ALU_A => ALU_A, ALU_B => ALU_B,
								      RF_A1 => RF_A1, RF_A2 => RF_A2, RF_A3 => RF_A3,state_vector => state_vector);

								  
MUX3 : MUX_2x1_4bits port map("0000", IR_out(15 downto 12),O,ALU_S);
MUX4 : MUX_2x1_3bits port map(IR_out(5 downto 3), IR_out(11 downto 9), SC_MUX, S_MUX);

IR <= IR_out;
ALU_out <= ALU_C;
Prog_counter <= PC_out;
Test <= T3_out;
state <= state_vector;
Z_flag<= Z_out;
end Struct;
								    