library ieee;
use ieee.std_logic_1164.all;


entity MUX_8X1_16bits is 
 port(A,B,C,D,E,F,G,H : in std_logic_vector(15 downto 0);S : in std_logic_vector(2 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end entity ;



architecture Struct of MUX_8X1_16bits is



component MUX_4X1_16bits is 
 port(A,B,C,D : in std_logic_vector(15 downto 0);S : in std_logic_vector(1 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end component ;

component MUX_2X1_16bits is 
 port(A,B : in std_logic_vector(15 downto 0);S : in std_logic;
         Y: out std_logic_vector(15 downto 0 ));
end component ;

signal C1,D1: std_logic_vector(15 downto 0):="0000000000000000";

begin

M1: MUX_4X1_16bits port map (A,B,C,D,S(1 downto 0),C1);
M2: MUX_4X1_16bits port map (E,F,G,H,S(1 downto 0),D1);
M3: MUX_2X1_16bits port map (C1,D1,S(2),Y);
end Struct;
