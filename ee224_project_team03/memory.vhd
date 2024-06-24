library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity memory is
port(	M_write:in std_logic;
		Mem_add:in std_logic_vector(15 downto 0);
		Mem_data_in:in std_logic_vector(15 downto 0);
		Mem_Data_out: out std_logic_vector(15 downto 0);
		clk:in std_logic);
end memory;

architecture mem_arc of memory is
	type typemem is array (0 to 65535) of std_logic_vector(15 downto 0);
	signal mem_data:typemem:= (others=>"0000000000000000");
begin
	process(clk)
	begin
	   
		if(falling_edge(clk)) then
			if(M_write='1') then
				mem_data(to_integer(unsigned(Mem_add)))<=Mem_data_in;
			end if;
			Mem_Data_out<=mem_data(to_integer(unsigned(Mem_add)));
			
		end if;
	end process;
	
end architecture;