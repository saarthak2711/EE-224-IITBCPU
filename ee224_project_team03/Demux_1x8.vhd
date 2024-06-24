library ieee;
use ieee.std_logic_1164.all;

entity Demux_1x8 is 
      port (A : in std_logic_vector (15 downto 0);
	         M : in std_logic_vector (2 downto 0);	
		      S1,S2,S3,S4,S5,S6,S7,S8: out std_logic_vector (15 downto 0));
end entity Demux_1x8;

architecture Struct of Demux_1x8 is

component Demux_1x2 is 
      port (A : in std_logic_vector (15 downto 0);
	         M : in std_logic;	
		      S1: out std_logic_vector (15 downto 0);
				S2: out std_logic_vector (15 downto 0));
end component Demux_1x2;

signal C1,C2,C3,C4,C5,C6 : std_logic_vector (15 downto 0);

begin 

Demux1 : Demux_1x2 port map (A,M(2),C1,C2);

Demux2 : Demux_1x2 port map (C1,M(1),C3,C4);
Demux3 : Demux_1x2 port map (C2,M(1),C5,C6);

Demux4 : Demux_1x2 port map (C3,M(0),S1,S2);
Demux5 : Demux_1x2 port map (C4,M(0),S3,S4);
Demux6 : Demux_1x2 port map (C5,M(0),S5,S6);
Demux7 : Demux_1x2 port map (C6,M(0),S7,S8);


end Struct;
