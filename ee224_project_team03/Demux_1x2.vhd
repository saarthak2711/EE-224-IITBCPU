library ieee;
use ieee.std_logic_1164.all;

entity Demux_1x2 is 
      port (A : in std_logic_vector (15 downto 0);
	         M : in std_logic;	
		      S1: out std_logic_vector (15 downto 0);
				S2: out std_logic_vector (15 downto 0));
end entity Demux_1x2;

architecture Struct of Demux_1x2 is

begin 

F0: for i in 0 to 15 generate 
    S1(i) <= (not M) and A(i);
	 S2(i) <= M and A(i);
end generate F0;

end Struct;
