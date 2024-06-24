library ieee;
use ieee.std_logic_1164.all;

entity Adder_7bit is
       port(A,B: in std_logic_vector (6 downto 0);
		      S: out std_logic_vector(6 downto 0); Cflag: out std_logic);
end entity Adder_7bit;

architecture Struct of Adder_7bit is 
 
component Full_Adder is
	port(A, B, Cin: in std_logic; S, Cout: out std_logic);
end component Full_Adder;
 
signal C : std_logic_vector (6 downto 0);

begin 



Full_Adder_0 : Full_Adder port map (A(0),B(0),'0',S(0),C(0));

F1: for i in 1 to 6 generate 
    Full_Adder_i : Full_Adder port map (A(i),B(i),C(i-1),S(i),C(i));
end generate F1;

Cflag <= C(6);

end Struct;