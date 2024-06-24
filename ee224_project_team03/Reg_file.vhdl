library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Reg_file is
  port (RF_A1, RF_A2, RF_A3: in std_logic_vector(2 downto 0);
		  RF_D1, RF_D2, PC_out: out std_logic_vector(15 downto 0);
		  RF_D3, PC_in: in std_logic_vector(15 downto 0);
		  RF_write,PC_write, clk, rst: in std_logic);
end entity Reg_file;

architecture regfile_str of Reg_file is

	component MUX_8X1_16bits is 
	 port(A,B,C,D,E,F,G,H : in std_logic_vector(15 downto 0); S: in std_logic_vector(2 downto 0);
				Y: out std_logic_vector(15 downto 0 ));
	end component;

	component Demux_1x8 is 
			port (A : in std_logic_vector (15 downto 0);
					M : in std_logic_vector (2 downto 0);	
					S1,S2,S3,S4,S5,S6,S7,S8: out std_logic_vector (15 downto 0));
	end component Demux_1x8;

	component REG_16b is
	  port (
		 Clock, Enable, Reset: in std_logic;
		 data_in : in std_logic_vector(15 downto 0);
		 data_out: out std_logic_vector(15 downto 0) 
	  );
	end component REG_16b;

	signal dout0, dout1, dout2, dout3, dout4, dout5, dout6, dout7: std_logic_vector(15 downto 0):="0000000000000000";
	signal din0, din1, din2, din3, din4, din5, din6, din7: std_logic_vector(15 downto 0);
	signal enb: std_logic_vector(7 downto 0):="00000000";

	begin

		r0: REG_16b port map(clk,enb(0),rst,din0,dout0);
		r1: REG_16b port map(clk,enb(1),rst,din1,dout1);
		r2: REG_16b port map(clk,enb(2),rst,din2,dout2);
		r3: REG_16b port map(clk,enb(3),rst,din3,dout3);
		r4: REG_16b port map(clk,enb(4),rst,din4,dout4);
		r5: REG_16b port map(clk,enb(5),rst,din5,dout5);
		r6: REG_16b port map(clk,enb(6),rst,din6,dout6);
		pc: REG_16b port map(clk,pc_write,rst,PC_in,PC_out);

		mux1: MUX_8X1_16bits port map(dout0, dout1, dout2, dout3, dout4, dout5, dout6, dout7, RF_A1, RF_D1);
		mux2: MUX_8X1_16bits port map(dout0, dout1, dout2, dout3, dout4, dout5, dout6, dout7, RF_A2, RF_D2);

		demux: Demux_1x8 port map(RF_D3, RF_A3, din0, din1, din2, din3, din4, din5, din6, din7);

		enable_proc: process(RF_A3)
		variable n: integer:=0;
		begin
			enb<="00000000";
--			n:= to_integer(unsigned(RF_A3));
			enb(to_integer(unsigned(RF_A3)))<='1';
		end process;

end regfile_str;
