library ieee;
use ieee.std_logic_1164.all;

entity DFK is
  port (
    d, reset, clk, en: in std_logic; -- data and clock inputs
    q: out std_logic -- output
  );
end DFK;

architecture behavior of DFK is

signal nemxt:std_logic:='0';

begin

  process (clk, reset) -- sensitivity list
  begin
	 
	 if (reset = '1') then
		nemxt <= '0';
	 
	 elsif (rising_edge(clk) and en = '1' ) then -- if clock is rising
			nemxt <= d;
	 	
    end if;
	
  end process;
  q <= nemxt;
 
end behavior;
