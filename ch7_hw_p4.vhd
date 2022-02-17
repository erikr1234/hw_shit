----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2022 12:34:09 PM
-- Design Name: 
-- Module Name: problem4 - problem4_structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2022 11:56:26 AM
-- Design Name: 
-- Module Name: bogus3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2t1 is --- ENTITY
port (  mux_A,mux_B   : in  std_logic_vector(7 downto 0);
		M_SEL         : in  std_logic;
		M_OUT         : out std_logic_vector(7 downto 0));
end mux2t1;
architecture my_mux of mux2t1 is --- ARCHITECTURE
begin
	with M_SEL select
		M_OUT <= mux_A when '1',
				 mux_B when '0',
				 (others => '0') when others;
end my_mux;
-----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg8 is --- ENTITY
	Port (  REG_IN  : in  std_logic_vector(7 downto 0);
			LD,CLK  : in  std_logic;
			REG_OUT : out std_logic_vector(7 downto 0));
end reg8;
architecture reg8 of reg8 is --- ARCHITECTURE
begin
	reg: process(CLK)
	begin
		if (rising_edge(CLK)) then
			if (LD = '1') then
				REG_OUT <= REG_IN;
			end if;
		end if;
	end process;
end reg8;
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity bogus is
	port (	X,Y        : in std_logic_vector(7 downto 0);
			S0,S1	   : in std_logic;
			CLK 	   : in std_logic;
			LDA,LDB,RD : in std_logic;
			RB,RA      : out std_logic_vector(7 downto 0));
end bogus;
architecture bogus_structural of bogus is
	component mux2t1
		port (  mux_A,mux_B : in  std_logic_vector(7 downto 0);
				M_SEL       : in  std_logic;
				M_OUT       : out std_logic_vector(7 downto 0));
	end component;
	component reg8
		port (  REG_IN  : in  std_logic_vector(7 downto 0);
				LD,CLK  : in  std_logic;
				REG_OUT : out std_logic_vector(7 downto 0));
	end component;
	signal s_reg_A, s_reg_B, s_mux_a, s_mux_b	: std_logic_vector(7 downto 0);
	signal reg_B_ld, reg_A_ld : std_logic;
begin
	reg_a: reg8
	port map ( 	REG_IN 	=> X,
				LD 		=> LDA,
				CLK 	=> CLK,
				REG_OUT => s_reg_A );
	reg_b: reg8
	port map ( 	REG_IN 	=> s_mux_a,
				LD 		=> LDB,
				CLK 	=> CLK,
				REG_OUT => RB );
	m1: mux2t1
	port map (	mux_A   => Y,
	            mux_B 	=> X,
				M_SEL 	=> S1,
				M_OUT 	=> s_mux_a);
	m2: mux2t1
	port map (	mux_A   => Y,
	            mux_B 	=> s_reg_B,
				M_SEL 	=> S0,
				M_OUT 	=> s_mux_b);
	RA <= s_reg_A;
	RB <= s_reg_B;
	special:
	process (LDA, LDB, RD) is
	   begin
	       reg_A_ld <= RD and LDA;
	       reg_B_ld <= (NOT RD) AND LDB;
	   end process special;
end architecture bogus_structural;