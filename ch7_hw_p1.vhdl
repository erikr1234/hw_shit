entity mux2t1 is --- ENTITY
port (  mux_A,mux_B   : in  std_logic_vector(7 downto 0);
		SEL   : in  std_logic;
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
----------------------------------------------------------------------------------
entity ckt_rtl is --- ENTITY
	port (	A,B 	: in  std_logic_vector(7 downto 0);
			CLK,SEL : in  std_logic;
			LDA		: in  std_logic;
			F 		: out std_logic_vector(7 downto 0));
end ckt_rtl;
architecture rtl_structural of ckt_rtl is --- ARCHITECTURE
	-- component declaration
	component mux2t1
	port ( 	mux_A,mux_B   : in  std_logic_vector(7 downto 0);
			SEL   : in  std_logic;
			M_OUT : out std_logic_vector(7 downto 0));
	end component;
	component reg8
	Port ( 	REG_IN  : in  std_logic_vector(7 downto 0);
			LD,CLK  : in  std_logic;
			REG_OUT : out std_logic_vector(7 downto 0));
	end component;
	-- intermediate signal declaration
	signal s_mux_result : std_logic_vector(7 downto 0);
begin
	ra: reg8
	port map ( 	REG_IN 	=> s_mux_result,
				LD 		=> LDA,
				CLK 	=> CLK,
				REG_OUT => F );
	m1: mux2t1
	port map ( 	mux_A 	=> A,
				mux_B	=> B,
				SEL 	=> SEL,
				M_OUT 	=> s_mux_result );
end rtl_structural
