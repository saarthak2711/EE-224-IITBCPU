library ieee;
use ieee.std_logic_1164.all;


entity S2 is 
 port(A : in std_logic_vector(15 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end entity ;


architecture Struct of S2 is


begin

f1: for i in 0 to 14 generate 

	y(i+1)<=A(i);
	
end generate f1; 

Y(0)<='0';


end Struct;
