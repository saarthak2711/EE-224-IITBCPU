library ieee;
use ieee.std_logic_1164.all;

entity Adder_Subtractor is
       port(A,B: in std_logic_vector (15 downto 0); M: in std_logic; 
		      S: out std_logic_vector(15 downto 0); Cflag: out std_logic);
end entity Adder_Subtractor;

architecture Struct of Adder_Subtractor is 
 
component Full_Adder is
	port(A, B, Cin: in std_logic; S, Cout: out std_logic);
end component Full_Adder;
 
signal P,C : std_logic_vector (15 downto 0);

begin 

F0: for i in 0 to 15 generate 
    P(i) <= B(i) xor M;
end generate F0;

Full_Adder_0 : Full_Adder port map (A(0),P(0),M,S(0),C(0));

F1: for i in 1 to 15 generate 
    Full_Adder_i : Full_Adder port map (A(i),P(i),C(i-1),S(i),C(i));
end generate F1;

Cflag <= C(15);

end Struct;