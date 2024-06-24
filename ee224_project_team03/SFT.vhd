library ieee;
use ieee.std_logic_1164.all;


entity SFT is 
 port(A : in std_logic_vector(7 downto 0);M: in std_logic_vector(3 downto 0);
         Y: out std_logic_vector(15 downto 0 ));
end entity ;


architecture Struct of SFT is

component MUX_2X1_16bits is 
 port(A,B : in std_logic_vector(15 downto 0);S : in std_logic;
         Y: out std_logic_vector(15 downto 0 ));
end component ;


signal LHI,LLI : std_logic_vector(15 downto 0);
begin


LLI<="00000000"&A;

LHI<= A&"00000000";
mux : MUX_2X1_16bits port map (LHI,LLI,M(0),Y);
end Struct;
