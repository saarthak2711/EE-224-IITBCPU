library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;

library work;
use work.all;


entity Testbench is 
end entity;

architecture IITBCPU_test_arc of Testbench is


component CPU is

port(PG_add,PG_data : in std_logic_vector (15 downto 0);
		       clk,reset,PG_write: in std_logic;
				 state : out std_logic_vector (4 downto 0);
				 IR : out std_logic_vector (15 downto 0);
				 ALU_out,Prog_counter,Test: out std_logic_vector (15 downto 0);
				 Z_flag: out std_logic);

end component;


	
	signal PG_ADD, PG_DATA : std_logic_vector(15 downto 0);
	signal clk : std_logic := '1';
	signal reset, PG_Write : std_logic:='0';
	signal state: std_logic_vector(4 downto 0);
	signal IR: std_logic_vector(15 downto 0);
	signal ALU_out,Prog_counter,Test: std_logic_vector(15 downto 0);
	signal Z_flag: std_logic;
	
begin
	dut_instance: CPU
		port map (PG_ADD => PG_ADD, PG_DATA => PG_DATA, clk => clk, reset => reset, PG_Write => PG_Write,state => state, IR => IR, ALU_out=> ALU_out,Prog_counter=>Prog_counter,Test=>Test, Z_flag=>Z_flag);
	
	
	process 
		
        file in_file: text open read_mode is "INSTRUCTION.txt";
        variable input_vector_var: std_logic_vector  (15 downto 0);
        variable INPUT_LINE: Line;
        variable count : integer range 0 to 64;
		
		begin
		
			count := 0;
			PG_ADD<= "0000000000000000";
			reset <= '1';
				
			-- load instructions in memory
			while (not endfile(in_file)) loop
				readline (in_file, INPUT_LINE);
				read (INPUT_LINE, input_vector_var);
				clk <= '1';
				PG_DATA<= input_vector_var;
				PG_Write<= '1';
				wait for 100 ns;
				clk <= '0';
				wait for 100 ns;
				PG_ADD<= std_logic_vector (unsigned(PG_ADD) + 1);
				count := count + 1;
	
			end loop;
			
			reset <= '0';
			PG_Write<= '0';
			clk <= '0';
			wait for 100 ns;
			clk <= '1';
			wait for 100 ns;
	
			reset <= '0';
			for i in 1 to 1000 loop
				clk <= '0';
				wait for 100 ns;
				clk <= '1';
				wait for 100 ns;
			end loop;
						
	wait;
	end process;
end architecture;











