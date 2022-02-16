library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2t1 is --- ENTITY
port (  mux_A,mux_B   : in  std_logic_vector(7 downto 0);
		M_SEL   : in  std_logic;
		M_OUT : out std_logic_vector(7 downto 0));
end mux2t1;
architecture my_mux of mux2t1 is --- ARCHITECTURE
begin
	with SEL select
		M_OUT <= A when '1',
				 B when '0',
				 (others => '0') when others;
end my_mux;
-----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg8 is --- ENTITY
	port (  REG_IN  : in  std_logic_vector(7 downto 0);
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
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity dec1t2 is --- ENTITY
	port (	D_SEL 			 : in  std_logic;
			D_OUT_0, D_OUT_1 : out std_logic);
end dec1t2;
architecture my_dec of dec1t2 is --- ARCHITECTURE
begin
    da_process: process (D_SEL) is
    begin
        if (D_SEL = '0') then
           D_OUT_0 <= '1';
           D_OUT_1 <= '0';
        elsif (D_SEL = '1') then
           D_OUT_0 <= '0';
           D_OUT_1 <= '1';
        else
           D_OUT_0 <= '0';
           D_OUT_1 <= '0';
        end if;
	end process da_process;
end my_dec;
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity bogus is
	port (	A,B,C 	: in std_logic_vector(7 downto 0);
			SL1,SL2 : in std_logic;
			CLK		: in std_logic;
			RAX,RBX	: out std_logic_vector(7 downto 0));
end bogus;
architecture bogus_structural of bogus is
	component mux2t1
	port ( 	mux_A,mux_B   : in  std_logic_vector(7 downto 0);
			SEL   : in  std_logic;
			M_OUT : out std_logic_vector(7 downto 0));
	end component;
	component reg8
		port (  REG_IN  : in  std_logic_vector(7 downto 0);
				LD,CLK  : in  std_logic;
				REG_OUT : out std_logic_vector(7 downto 0));
	end component;
	component dec1t2 is
		port (	D_SEL 			 : in  std_logic;
				D_OUT_0, D_OUT_1 : out std_logic);
	end component;
	signal s_mux_result		: std_logic_vector(7 downto 0);
	signal s_dec_0, s_dec_1 : std_logic;
begin
	reg_a: reg8
	port map ( 	REG_IN 	=> A,
				LD 		=> s_dec_1,
				CLK 	=> CLK,
				REG_OUT => RAX );
	reg_b: reg8
	port map ( 	REG_IN 	=> s_mux_result,
				LD 		=> s_dec_0,
				CLK 	=> CLK,
				REG_OUT => RBX );
	m1: mux2t1
	port map (	mux_A   => B,
	            mux_B 	=> C,
				M_SEL 	=> SL2,
				M_OUT 	=> s_mux_result );
	d1: dec1t2
	port map (	D_SEL 	=> SL1,
	            D_OUT_0 => s_dec_0,
	            D_OUT_1 => s_dec_1 );
end architecture bogus_structural;