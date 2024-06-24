library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder is
	port(A, B, Cin: in std_logic; S, Cout: out std_logic);
end entity Full_Adder;

architecture Struct of Full_Adder is
	signal ha1out, c1, c2: std_logic;
begin
	S<= A xor B xor Cin;
	Cout <= (A and B) or (B and Cin) or (A and Cin);
end Struct;