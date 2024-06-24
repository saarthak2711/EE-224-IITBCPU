library ieee;
use ieee.std_logic_1164.all;


entity SE_6 is 
 port(A : in std_logic_vector(5 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end entity ;




architecture Struct of SE_6 is


begin

Y<=A(5)&A(5)&A(5)&A(5)&A(5)&A(5)&A(5)&A(5)&A(5)&A(5)&A;


end Struct;
