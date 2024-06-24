library ieee;
use ieee.std_logic_1164.all;

entity REG_16b is
  port (
    Clock, Enable, Reset: in std_logic; -- data and clock inputs
	 data_in : in std_logic_vector(15 downto 0);
    data_out: out std_logic_vector(15 downto 0) -- output
  );
end REG_16b;

architecture Struct of REG_16b is
signal qb:std_logic;
signal qb_bar:std_logic;
signal d_logic:std_logic;

component DFK is
  port (
    d, reset, clk, en: in std_logic; -- data and clock inputs
    q: out std_logic -- output
  );
end component;

begin


DF0 : DFK port map(d => data_in(0), reset => Reset, clk => Clock, en => Enable, q => data_out(0));
DF1 : DFK port map(d => data_in(1), reset => Reset, clk => Clock, en => Enable, q => data_out(1));
DF2 : DFK port map(d => data_in(2), reset => Reset, clk => Clock, en => Enable, q => data_out(2));
DF3 : DFK port map(d => data_in(3), reset => Reset, clk => Clock, en => Enable, q => data_out(3));
DF4 : DFK port map(d => data_in(4), reset => Reset, clk => Clock, en => Enable, q => data_out(4));
DF5 : DFK port map(d => data_in(5), reset => Reset, clk => Clock, en => Enable, q => data_out(5));
DF6 : DFK port map(d => data_in(6), reset => Reset, clk => Clock, en => Enable, q => data_out(6));
DF7 : DFK port map(d => data_in(7), reset => Reset, clk => Clock, en => Enable, q => data_out(7));
DF8 : DFK port map(d => data_in(8), reset => Reset, clk => Clock, en => Enable, q => data_out(8));
DF9 : DFK port map(d => data_in(9), reset => Reset, clk => Clock, en => Enable, q => data_out(9));
DF10 : DFK port map(d => data_in(10), reset => Reset, clk => Clock, en => Enable, q => data_out(10));
DF11 : DFK port map(d => data_in(11), reset => Reset, clk => Clock, en => Enable, q => data_out(11));
DF12 : DFK port map(d => data_in(12), reset => Reset, clk => Clock, en => Enable, q => data_out(12));
DF13 : DFK port map(d => data_in(13), reset => Reset, clk => Clock, en => Enable, q => data_out(13));
DF14 : DFK port map(d => data_in(14), reset => Reset, clk => Clock, en => Enable, q => data_out(14));
DF15 : DFK port map(d => data_in(15), reset => Reset, clk => Clock, en => Enable, q => data_out(15));

end Struct;
