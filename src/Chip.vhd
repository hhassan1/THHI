----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:31:53 11/13/2014 
-- Design Name: 
-- Module Name:    Chip - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

entity Chip is
    Port ( main_clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ps2_clk : in STD_LOGIC;
			  ps2_data : in STD_LOGIC;
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC;
           rgb : out  STD_LOGIC_VECTOR (8 downto 0);
			  tec : out STD_LOGIC_VECTOR(6 downto 0);
			  transmiting : out STD_LOGIC;
			  data_re : out STD_LOGIC;
			  error : out STD_LOGIC;
--           sclkfb : in    std_logic;
--			  sclk   : out   std_logic;
--			  cke    : out   std_logic;
--			  cs_n   : out   std_logic;
--			  ras_n  : out   std_logic;
--			  cas_n  : out   std_logic;
--			  we_n   : out   std_logic;
--			  ba     : out   unsigned(1 downto 0);
--			  sAddr  : out   unsigned(12 downto 0);
--			  sData  : inout unsigned(15 downto 0);
--			  dqmh   : out   std_logic;
--			  dqml   : out   std_logic;
			  pwm : out STD_LOGIC
			 );
end Chip;

architecture Behavioral of Chip is
component personaje is
	port (reset: in std_logic;
			clk: in std_logic;
			start_b : in std_logic;
			left_b : in std_logic;
			right_b : in std_logic;
			attack_b : in std_logic;
			vga_x, vga_y : in UNSIGNED(9 downto 0);
			ball_x : in UNSIGNED(9 downto 0);
			ball_y : in UNSIGNED(8 downto 0);
			pinta_personaje : out std_logic;
			rgb_personaje : out std_logic_vector(8 downto 0);
			collision : out std_logic;
			ataque: out std_logic;
			dead : out std_logic
			);
end component;
component PS2Interface is
    Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  ps2_clk : in STD_LOGIC;
			  ps2_data : in STD_LOGIC;
           keyboard : out STD_LOGIC_VECTOR(6 downto 0);
			  transmiting : out STD_LOGIC;
           data_re : out STD_LOGIC;
           error : out STD_LOGIC);
end component;
component divisor is
	generic
	(
		input		:	natural := 100000000;
		output	:	natural := 25000000
	);
   port
	(
		reset: in STD_LOGIC;
		clk_entrada: in STD_LOGIC; 
		clk_salida: out STD_LOGIC
	);
end component;
component vga_sync is
	port (
			clk, reset: in std_logic;
			hsync, vsync : out std_logic;
			video_on : out std_logic;
			pixel_x , pixel_y : out UNSIGNED (9 downto 0)
		);
end component;
component cards is
	port
	(
		clk 				:	in STD_LOGIC;
		reset 			:	in STD_LOGIC;
		load_cards		:	in STD_LOGIC;
		level           :   in UNSIGNED(2 downto 0);
		ball_x			:	in UNSIGNED(9 downto 0);
		ball_y			:	in UNSIGNED(8 downto 0);
		vga_x				:	in UNSIGNED(9 downto 0);
		vga_y				:	in UNSIGNED(9 downto 0);
		no_cards_left	:	out STD_LOGIC;
		loaded			:	out STD_LOGIC;
		draw_sprite		:	out STD_LOGIC;
		card_out			:	out STD_LOGIC;
		rgb 				:	out STD_LOGIC_VECTOR(8 downto 0)
	);
end component;
component bola is
 port
	(	
		clk: in std_logic;
    rst: in std_logic;
    start_b : in std_logic;
    ataca: in std_logic;
    col_per: in std_logic;
    vga_x, vga_y : in UNSIGNED(9 downto 0);
    pos_x : out UNSIGNED(9 downto 0);
    pos_y : out UNSIGNED(8 downto 0);
    pinta_bola : out std_logic;
    rgb_bola : out std_logic_vector(8 downto 0)
    );
end component;
component background_1 is
	port
	(
		clk  : in STD_LOGIC;
		reset: in STD_LOGIC;
		vga_x: in UNSIGNED(9 downto 0);
		vga_y: in UNSIGNED(9 downto 0);
		rgb:	out STD_LOGIC_VECTOR(8 downto 0)
	);
end component;
component background_2 is
	port
	(
		clk  : in STD_LOGIC;
		reset: in STD_LOGIC;
		v_on : in STD_LOGIC;
		vga_x: in UNSIGNED(9 downto 0);
		clk_sync : out STD_LOGIC;
		sclkfb : in    std_logic;
		sclk   : out   std_logic;
		cke    : out   std_logic;
		cs_n   : out   std_logic;
		ras_n  : out   std_logic;
		cas_n  : out   std_logic;
		we_n   : out   std_logic;
		ba     : out   unsigned(1 downto 0);
		sAddr  : out   unsigned(12 downto 0);
		sData  : inout unsigned(15 downto 0);
		dqmh   : out   std_logic;
		dqml   : out   std_logic;
		rgb:	out STD_LOGIC_VECTOR(8 downto 0)
	);
end component;
component Sound is
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		ampPWM : out std_logic;
		ampSD : out std_logic
	);
end component;
component overlay is
	port(
		clk		:	in STD_LOGIC;
		reset		:	in STD_LOGIC;
		interleave : in STD_LOGIC;
		level		:	in UNSIGNED(2 downto 0);
		points	:	in UNSIGNED(23 downto 0);
		lives		:	in UNSIGNED(2 downto 0);
		vga_x		:	in UNSIGNED(9 downto 0);
		vga_y		:	in UNSIGNED(9 downto 0);
		draw_sprite	:	out STD_LOGIC;
		rgb 			:	out STD_LOGIC_VECTOR(8 downto 0)
	);
end component;
component endscreen is
	port
	(
		win		:	in STD_LOGIC;
		vga_x		:	in UNSIGNED(9 downto 0);
		vga_y		:	in UNSIGNED(9 downto 0);
		draw_sprite	:	out STD_LOGIC
	);
end component;
component startscreen is
	port
	(
		vga_x		:	in UNSIGNED(9 downto 0);
		vga_y		:	in UNSIGNED(9 downto 0);
		draw_sprite	:	out STD_LOGIC
	);
end component;

type estados is (INICIAL, CARGAR_CARTAS, CARGANDO, JUGANDO, INTERMEDIO_CARGANDO, INTERMEDIO_CARGAR_CARTAS, FIN_JUEGO, JUEGO_PERDIDO);
signal estado, estado_sig : estados;
signal keyboard : STD_LOGIC_VECTOR(6 downto 0);
signal pinta_personaje,pinta_carta,draw_end, draw_start, loaded, load_cards, ataque,v_on,col_bola,pinta_bola,vsyncb, no_cards, reset_cambio_nivel,reset, draw_overlay, interleave : std_logic;
signal clock_rel : STD_LOGIC := '0';
signal level_c : UNSIGNED(2 downto 0);
signal vga_x,vga_y, bx : UNSIGNED (9 downto 0);
signal by : UNSIGNED (8 downto 0);
signal rgb_personaje,rgb_bola, rgb_cartas, rgb_bg, rgb_overlay : std_logic_vector(8 downto 0);
signal dead, carta_eliminada : std_logic;
signal puntos : UNSIGNED(23 downto 0);
signal vidas : UNSIGNED(2 downto 0);
signal end_select : STD_LOGIC;
begin
reset <= not rst;
load_cards <= '1' when estado = CARGAR_CARTAS or estado = INTERMEDIO_CARGAR_CARTAS else '0';
reset_cambio_nivel <= '1' when reset = '1' or estado /= JUGANDO else '0';
vsync <= vsyncb;
tec <= keyboard;
end_select <= '1' when estado = FIN_JUEGO else '0';
bg : background_1 port map (main_clk, reset, vga_x, vga_y,rgb_bg);
per : personaje port map (reset_cambio_nivel,vsyncb, '1', keyboard(1),keyboard(0),keyboard(5), vga_x, vga_y, bx, by, pinta_personaje, rgb_personaje, col_bola, ataque, dead);
endsrc : endscreen port map (end_select,vga_x, vga_y, draw_end);
startsrc : startscreen port map (vga_x, vga_y, draw_start);

car : cards port map (clock_rel, reset, load_cards,level_c, bx, by, vga_x, vga_y, no_cards,loaded,pinta_carta,carta_eliminada,rgb_cartas);
bol : bola port map (vsyncb, reset_cambio_nivel, ataque, ataque, col_bola, vga_x, vga_y, bx, by, pinta_bola, rgb_bola);
vga : vga_sync port map (clock_rel,reset,hsync,vsyncb,v_on,vga_x,vga_y);
bgm : sound port map (main_clk,reset_cambio_nivel,pwm,open);
over : overlay port map (clock_rel, reset, interleave, level_c, puntos, vidas, vga_x, vga_y, draw_overlay, rgb_overlay);
interleave <= '1' when estado = INTERMEDIO_CARGANDO else '0';
rgb <= "000000000" when v_on = '0' else
		 "111111111" when ((estado = FIN_JUEGO or estado = JUEGO_PERDIDO) and draw_end = '1') or (estado = CARGANDO and draw_start = '1') else
		 rgb_overlay when draw_overlay = '1' and estado /= CARGANDO and estado /= FIN_JUEGO and estado /= JUEGO_PERDIDO else
		 rgb_personaje when pinta_personaje = '1' and estado /= CARGANDO and estado /= FIN_JUEGO and estado /= JUEGO_PERDIDO else
		 rgb_bola when pinta_bola = '1' and estado = JUGANDO else
		 rgb_cartas when pinta_carta = '1' and estado = JUGANDO else
		 rgb_bg  when estado /= CARGANDO and estado /= FIN_JUEGO and estado /= JUEGO_PERDIDO else
		 "000000000";
--rgb <= "000000000" when v_on = '0' else
--		 "111111111" when (estado = FIN_JUEGO or estado = JUEGO_PERDIDO) and v_on = '1' else
--       "000111000" when estado = INTERMEDIO_CARGANDO and v_on = '1' else
--		 rgb_overlay when draw_overlay = '1' else
--		 rgb_personaje when pinta_personaje = '1' else
--		 rgb_bola when pinta_bola = '1' else
--		 rgb_cartas when pinta_carta = '1' else
--		 rgb_bg when v_on = '1' else
--		 --"111100001111" when v_on = '1' and (vga_x(0) xor vga_y(0)) = '0' else
--		 "000000000";
--rgb <= "000000000000" when v_on = '0' else
--		 "111111111111" when ((estado = FIN_JUEGO or estado = JUEGO_PERDIDO) and draw_end = '1') or (estado = CARGANDO and draw_start = '1') else
--		 rgb_overlay(8 downto 6) & '0' & rgb_overlay(5 downto 3) & '0' & rgb_overlay(2 downto 0) & '0' when draw_overlay = '1' and estado /= CARGANDO and estado /= FIN_JUEGO and estado /= JUEGO_PERDIDO else
--		 rgb_personaje(8 downto 6) & '0' & rgb_personaje(5 downto 3) & '0' & rgb_personaje(2 downto 0) & '0' when pinta_personaje = '1' and estado /= CARGANDO and estado /= FIN_JUEGO and estado /= JUEGO_PERDIDO else
--		 rgb_bola(8 downto 6) & '0' & rgb_bola(5 downto 3) & '0' & rgb_bola(2 downto 0) & '0' when pinta_bola = '1' and estado = JUGANDO else
--		 rgb_cartas(8 downto 6) & '0' & rgb_cartas(5 downto 3) & '0' & rgb_cartas(2 downto 0) & '0' when pinta_carta = '1' and estado = JUGANDO else
--		 rgb_bg(8 downto 6) & '0' & rgb_bg(5 downto 3) & '0' & rgb_bg(2 downto 0) & '0'  when estado /= CARGANDO and estado /= FIN_JUEGO and estado /= JUEGO_PERDIDO else
--		 "000000000000";
ps2 : PS2Interface port map (main_clk, reset, ps2_clk, ps2_data, keyboard, transmiting, data_re, error);
div_d : divisor port map (reset,main_clk,clock_rel);
process (reset, clock_rel)
begin
	if reset = '1' then
		estado <= INICIAL;
		level_c <= to_unsigned(1,3);
		puntos <= to_unsigned(0,puntos'length);
	elsif rising_edge(clock_rel) then
		estado <= estado_sig;
		if estado = INTERMEDIO_CARGAR_CARTAS then
		  level_c <= level_c + 1;
		end if;
		if carta_eliminada = '1' then
			if level_c = 1 then
				puntos <= puntos + to_unsigned(500,24);
			elsif level_c = 2 then
				puntos <= puntos + to_unsigned(1000,24);
			else
				puntos <= puntos + to_unsigned(1500,24);
			end if;
		end if;
	end if;
end process;
process(reset, vsyncb)
begin
	if reset = '1' then
		vidas <= to_unsigned(6,3);
	elsif rising_edge(vsyncb) then
		if dead = '1' then
			vidas <= vidas - 1;
		end if;
	end if;
end process;
process (estado, loaded, no_cards, level_c, keyboard,vidas)
begin
	case estado is
		when INICIAL
			=> estado_sig <= CARGAR_CARTAS;
		when CARGAR_CARTAS
			=> estado_sig <= CARGANDO;
		when CARGANDO
			=> if loaded = '1' and keyboard(6) = '1' then
					estado_sig <= JUGANDO;
				else
					estado_sig <= CARGANDO;
				end if;
		when JUGANDO
			=> if vidas = 0 then
					estado_sig <= JUEGO_PERDIDO;
				elsif no_cards = '1' and level_c /= 3 then
					estado_sig <= INTERMEDIO_CARGAR_CARTAS;
			     elsif no_cards = '1' and level_c = 3 then
			         estado_sig <= FIN_JUEGO;
				else
					estado_sig <= JUGANDO;
				end if;
		when INTERMEDIO_CARGAR_CARTAS
		      => estado_sig <= INTERMEDIO_CARGANDO;
		when INTERMEDIO_CARGANDO
		      => if loaded = '1' and keyboard(6) = '1' then
                    estado_sig <= JUGANDO;
                else
                    estado_sig <= INTERMEDIO_CARGANDO;
                end if;
		when JUEGO_PERDIDO
			=> estado_sig <= JUEGO_PERDIDO;
		when FIN_JUEGO
			=> estado_sig <= FIN_JUEGO;
	end case;
end process;
end Behavioral;