library ieee;
use ieee.std_logic_1164.all;


entity SE_9 is 
 port(A : in std_logic_vector(8 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end entity ;




architecture Struct of SE_9 is


begin

Y<=A(8)&A(8)&A(8)&A(8)&A(8)&A(8)&A(8)&A;


end Struct;
