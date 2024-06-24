library ieee;
use ieee.std_logic_1164.all;

entity ALU is
    port (
        ALU_A: in std_logic_vector(15 downto 0);
        ALU_B: in std_logic_vector(15 downto 0);
        Sel: in std_logic_vector(3 downto 0);
        ALU_C: out std_logic_vector(15 downto 0);
		  ALU_Z: out std_logic
    );
end ALU;

architecture Struct of ALU is
    signal cf,cf1: std_logic := '0';
    signal Y1, A1, S1,Bitwise_and,Bitwise_or,Implication: std_logic_vector(15 downto 0):= "0000000000000000";
	 signal zero : std_logic_vector (15 downto 0):= "0000000000000000";
	 signal op : std_logic_vector (2 downto 0):="000";

    component Adder_Subtractor is
        port (
            A, B: in std_logic_vector(15 downto 0);
            M: in std_logic;
            S: out std_logic_vector(15 downto 0);
            Cflag: out std_logic
        );
    end component Adder_Subtractor;

    component Multiplier is
        port (
            A, B: in std_logic_vector(15 downto 0);
            S: out std_logic_vector(15 downto 0)
        );
    end component Multiplier;
	 
component MUX_8X1_16bits is 
 port(A,B,C,D,E,F,G,H : in std_logic_vector(15 downto 0); S : in std_logic_vector(2 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
			
end component ;

begin
    add1: Adder_Subtractor port map(A=>ALU_A, B=>ALU_B, M=>'0', S=>A1,cflag=>cf);
    add2: Adder_Subtractor port map(A=>ALU_A, B=>Alu_B, M=>'1', S=>S1,cflag=>cf1);
    m1: Multiplier port map(A=>ALU_A, B=>ALU_B, S=>Y1);
	 Bitwise_and <= ALU_A and ALU_B;
	 Bitwise_or <= ALU_A or ALU_B;
	 Implication <= (not ALU_A) or ALU_B ;
	 op <= Sel( 2 downto 0); 

MUX1 :MUX_8X1_16bits port map(A => A1, B => zero, C => S1, D => Y1,E => Bitwise_and, F => Bitwise_or, 
                              G => Implication, H => zero,S => Sel(2 downto 0), Y => AlU_C);

	

ALU_Z<=not (S1(0) or S1(1) or S1(2) or S1(3) or S1(4) or S1(5) or 
 S1(6) or S1(7) or S1(8) or S1(9) or S1(10) or S1(11) or S1(12) or S1(13) or S1(14) or S1(15));
end Struct; -- a1
