library ieee;
use ieee.std_logic_1164.all;

entity Multiplier is
       port(A,B: in std_logic_vector (15 downto 0); 
		      S: out std_logic_vector(15 downto 0));
end entity Multiplier;

architecture Struct of Multiplier is 
 
component Full_Adder is
	port(A, B, Cin: in std_logic; S, Cout: out std_logic);
end component Full_Adder;

component Adder_7bit is
       port(A,B: in std_logic_vector (6 downto 0);
		      S: out std_logic_vector(6 downto 0); Cflag: out std_logic);
end component Adder_7bit;
 
signal AB0,AB1,AB2,AB3 : std_logic_vector (6 downto 0) := "0000000";
signal T0,T1 : std_logic_vector (6 downto 0);
signal C0,C1,C3 : std_logic;

begin 

F0: for i in 0 to 3 generate
		AB0(i)<= A(i) and B(0);
	end generate F0;
	
F1: for i in 0 to 3 generate
		AB1(i+1)<= A(i) and B(1);
	end generate F1;
	
F2: for i in 0 to 3 generate
		AB2(i+2)<= A(i) and B(2);
	end generate F2;
	
F3: for i in 0 to 3 generate
      AB3(i+3)<= A(i) and B(3);
    end generate F3;
	
Adder1 : Adder_7bit port map ( AB0, AB1, T0, C0);
Adder2 : Adder_7bit port map ( T0, AB2, T1, C1);
Adder3 : Adder_7bit port map (T1, AB3, S(6 downto 0), S(7));

S(15 downto 8) <= "00000000";
end Struct;