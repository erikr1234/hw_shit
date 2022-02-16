entity mux4t1 is --- ENTITY
	port (  mux_A,mux_B,mux_C,mux_D  : in  std_logic_vector(7 downto 0);
			M_SEL : in  std_logic_vector(1 downto 0);
			M_OUT : out std_logic_vector(7 downto 0));
end mux4t1;
architecture my_mux of mux4t1 is --- ARCHITECTURE
begin
	with SEL select
		M_OUT <= A when '00',
				 B when '01',
				 C when '10',
				 D when '11',
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
entity dec1t2 is --- ENTITY
	port (	D_SEL 			 : in  std_logic;
			D_OUT_0, D_OUT_1 : out std_logic);
end dec1t2;
architecture my_dec of dec1t2 is --- ARCHITECTURE
begin
	with D_SEL select
		D_OUT_0 <= 	'1' when '0',
					'0' when '1',
				 	(others => '0') when others;
		D_OUT_1 <= 	'0' when '0',
					'1' when '1',
				 	(others => '0') when others;
end dec1t2;
----------------------------------------------------------------------------------
entity bogus is
	port (	X,Y,X 	: in std_logic_vector(7 downto 0);
			DS 		: in std_logic;
			CLK		: in std_logic;
			MS 		: in std_logic_vector(1 downto 0);
			RA,RB	: out std_logic_vector(7 downto 0));
end bogus;
architecture bogus_structural of bogus is
	component mux4t1
		port (  mux_A,mux_B,mux_C,mux_D  : in  std_logic_vector(7 downto 0);
				M_SEL : in  std_logic_vector(1 downto 0);
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
	signal s_reg_A, s_reg_B, s_mux_result	: std_logic_vector(7 downto 0);
	signal s_dec_0, s_dec_1 				: std_logic;
begin
	ra: reg8
	port map ( 	REG_IN 	=> s_mux_result,
				LD 		=> LDA,
				CLK 	=> CLK,
				REG_OUT => RA );
	rb: reg8
	port map ( 	REG_IN 	=> RA,
				LD 		=> LDA,
				CLK 	=> CLK,
				REG_OUT => RB );
	m1: mux4t1
	port map (	mux_B 	=> Z,
				mux_C	=> Y,
				mux_D	=> X,
				M_SEL 	=> MS,
				M_OUT 	=> s_mux_result);
	d1: dec1t2
	port map (	D_SEL 	=> DS,
				CLK		=> CLK );
	mux_A <= RB;
end architecture bogus_structural;






