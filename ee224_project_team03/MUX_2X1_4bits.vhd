library ieee;
use ieee.std_logic_1164.all;


entity MUX_2X1_4bits is 
 port(A,B : in std_logic_vector(3 downto 0);S : in std_logic;
         Y: out std_logic_vector(3 downto 0 ));
end entity ;




architecture Struct of MUX_2X1_4bits is
signal y1: std_logic_vector(3 downto 0);

begin

F1: for i in 0 to 3 generate 

Y1(i)<= ((not S) and A(i)) or (S and B(i));
end generate;

y<=y1;


end Struct;
