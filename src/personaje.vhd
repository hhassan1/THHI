----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:52:38 11/09/2014 
-- Design Name: 
-- Module Name:    personaje - Behavioral 
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
use work.Types.ALL;

entity personaje is
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
end personaje;

architecture Behavioral of personaje is
component ball_player_collision is port (	attack : in STD_LOGIC; player_x : in UNSIGNED(9 downto 0);	player_y : in UNSIGNED(9 downto 0);	ball_x : in UNSIGNED(9 downto 0); ball_y : in UNSIGNED(8 downto 0); collision : out STD_LOGIC); end component;
component player_sprite_standing is port ( x: in STD_LOGIC_VECTOR(9 downto 0); colour	:	out STD_LOGIC_VECTOR(2 downto 0)); end component;
component player_sprite_moving_1 is	port ( x: in STD_LOGIC_VECTOR(9 downto 0); colour	:	out STD_LOGIC_VECTOR(2 downto 0)); end component;
component player_sprite_moving_2 is port ( x: in STD_LOGIC_VECTOR(9 downto 0); colour	:	out STD_LOGIC_VECTOR(2 downto 0)); end component;
component player_sprite_attack_1 is port ( x: in STD_LOGIC_VECTOR(10 downto 0);colour   :   out STD_LOGIC_VECTOR(2 downto 0)); end component;
component player_sprite_attack_2 is port ( x: in STD_LOGIC_VECTOR(10 downto 0);colour   :   out STD_LOGIC_VECTOR(2 downto 0)); end component;
component player_sprite_attack_3 is port ( x: in STD_LOGIC_VECTOR(10 downto 0);colour   :   out STD_LOGIC_VECTOR(2 downto 0)); end component;
component player_sprite_attack_4 is port ( x: in STD_LOGIC_VECTOR(10 downto 0);colour   :   out STD_LOGIC_VECTOR(2 downto 0)); end component;
type EstadoPersona is (Inicio,Quieto, Mover_izq, Mover_der, Atacar, Muerto);
signal estado, estado_sig :EstadoPersona;
constant player_x_default : integer := 320;
constant player_y : integer := 479;
---------------------
signal player_x, player_x_next: unsigned(9 downto 0);
signal sprite_c, sprite_c_next : unsigned(2 downto 0);
signal dead_c, dead_c_next : unsigned(5 downto 0);
signal attack_c, attack_c_next : unsigned(5 downto 0);
----------------
signal invulnerable, col_bola, mov_anim, muerto_anim, atq : std_logic;
signal rgb_dec, colour_standing,colour_moving_1,colour_moving_2,colour_attack_1,colour_attack_2,colour_attack_3,colour_attack_4 : STD_LOGIC_VECTOR(2 downto 0);
signal x_sprite, x_mov_1, x_mov_2 : STD_LOGIC_VECTOR(9 downto 0);
signal x_attack_1, x_attack_2, x_attack_3, x_attack_4 : STD_LOGIC_VECTOR(10 downto 0);
begin

player_x_next	<=	player_x when (estado = Quieto) or (estado = Atacar) or (estado = Mover_der and player_x + quieto_width >= pared_der) or (estado = Mover_izq and player_x <= pared_izq) else
						player_x + 4 when estado = Mover_der else
						player_x - 4 when estado = Mover_izq else
						to_unsigned(player_x_default,player_x_next'length);
sprite_c_next	<=	sprite_c + 1 when estado = Mover_der or estado = Mover_izq else
						(others => '0');
dead_c_next		<=	dead_c + 1 when estado = Muerto or dead_c /= 0 else
						dead_c;
attack_c_next	<=	(others => '0') when attack_c = 55 else
						attack_c + 1 when estado = Atacar or attack_c /= 0 else
						attack_c;
mov_anim <= sprite_c(sprite_c'left);
muerto_anim <= dead_c(4);
collision <= col_bola;
ataque <= atq;
atq <= '1' when estado = Atacar else '0';
invulnerable <= '1' when dead_c /= 0 else '0';
pinta_personaje <= '1' when rgb_dec /= ALPHA_3 else '0';
x_sprite <= std_logic_vector(resize(player_y - vga_y,5)) & std_logic_vector(resize(vga_x - player_x,5));
x_mov_1	<=	std_logic_vector(resize(player_y - vga_y,5)) & std_logic_vector(resize(mov1_width - 1 - (vga_x - player_x),5)) when estado = Mover_der else 
				std_logic_vector(resize(player_y - vga_y,5)) & std_logic_vector(resize(vga_x - player_x,5));
x_mov_2 	<=	std_logic_vector(resize(player_y - vga_y,5)) & std_logic_vector(resize(mov2_width - 1 - (vga_x - player_x),5)) when estado = Mover_der else 
				std_logic_vector(resize(player_y - vga_y,5)) & std_logic_vector(resize(vga_x - player_x,5));
x_attack_1 	<=	std_logic_vector(resize((player_y - vga_y)*33 + (vga_x - player_x),11)) when attack_c < 8 else
					std_logic_vector(resize((player_y - vga_y + 1)*33 - (vga_x - player_x) - 1,11));
x_attack_2 	<=	std_logic_vector(resize((player_y - vga_y)*39 + (vga_x - player_x),11)) when (attack_c >= 8 and attack_c < 16) else
					std_logic_vector(resize((player_y - vga_y + 1)*39 - (vga_x - player_x) - 1,11));
x_attack_3 	<=	std_logic_vector(resize((player_y - vga_y)*42 + (vga_x - player_x),11)) when (attack_c >= 16 and attack_c < 24) else
					std_logic_vector(resize((player_y - vga_y + 1)*42 - (vga_x - player_x) - 1,11));
x_attack_4 	<=	std_logic_vector(resize((player_y - vga_y)*33 + (vga_x - player_x),11));

coll : ball_player_collision port map (atq ,player_x, to_unsigned(player_y,10), ball_x, ball_y, col_bola);

standing_sprite: player_sprite_standing port map (x_sprite, colour_standing);
moving_1_sprite: player_sprite_moving_1 port map (x_mov_1, colour_moving_1);
moving_2_sprite: player_sprite_moving_2 port map (x_mov_2, colour_moving_2);
attack_1_sprite: player_sprite_attack_1 port map (x_attack_1,colour_attack_1);
attack_2_sprite: player_sprite_attack_2 port map (x_attack_2,colour_attack_2);
attack_3_sprite: player_sprite_attack_3 port map (x_attack_3,colour_attack_3);
attack_4_sprite: player_sprite_attack_4 port map (x_attack_4,colour_attack_4);
rgb_dec <=	colour_standing when (estado = Inicio or estado = Quieto) and (player_x <= vga_x and vga_x < player_x +quieto_width and player_y >= vga_y and vga_y + quieto_height > player_y) else
				colour_moving_1 when (estado = Mover_izq or estado = Mover_der) and mov_anim = '0' and player_x <= vga_x and vga_x < player_x + mov1_width and player_y >= vga_y and vga_y + mov1_height > player_y else
				colour_moving_2 when (estado = Mover_izq or estado = Mover_der) and mov_anim = '1' and player_x <= vga_x and vga_x < player_x + mov2_width and player_y >= vga_y and vga_y + mov2_height > player_y else
				colour_attack_1 when (estado = Atacar) and (player_x <= vga_x and vga_x < player_x + 33 and player_y >= vga_y and vga_y + 33 > player_y) and (attack_c < 8 or (attack_c >= 32 and attack_c < 40)) else 
				colour_attack_2 when (estado = Atacar) and (player_x <= vga_x and vga_x < player_x + 39 and player_y >= vga_y and vga_y + 37 > player_y) and ((attack_c >= 8 and attack_c < 16) or (attack_c >= 40 and attack_c < 48)) else 
				colour_attack_3 when (estado = Atacar) and (player_x <= vga_x and vga_x < player_x + 42 and player_y >= vga_y and vga_y + 42 > player_y) and ((attack_c >= 16 and attack_c < 24) or attack_c >= 48) else
				colour_attack_4 when (estado = Atacar) and (player_x <= vga_x and vga_x < player_x + 33 and player_y >= vga_y and vga_y + 35 > player_y) and ((attack_c >= 24 and attack_c < 32)) else
				ALPHA_3;
dead <= '1' when estado = Muerto else '0';
process(reset,clk)
begin
	if reset ='1' then
		estado <= Inicio;
		player_x	<= to_unsigned(player_x_default,player_x'length);
		dead_c	<=	(others => '0');
		sprite_c	<=	(others => '0');
		attack_c	<=	(others => '0');
	elsif rising_edge(clk) then
		estado<=estado_sig;
		player_x	<= player_x_next;
		dead_c	<=	dead_c_next;
		sprite_c	<=	sprite_c_next;
		attack_c	<=	attack_c_next;
	end if;
end process;

process (estado, start_b, right_b, left_b, attack_b, attack_c, ball_x, ball_y, mov_anim, col_bola, invulnerable)
begin
	case estado is
		when Inicio	
					=>	if start_b = '1' then
							estado_sig <= Quieto;
						else
							estado_sig <= Inicio;
						end if;
		when Quieto|Mover_izq|Mover_der
					=> if attack_b = '1' and attack_c = 0 then
					       estado_sig <= Atacar;
					   elsif col_bola = '1' and invulnerable = '0' then
					       estado_sig <= Muerto;
					   elsif (right_b and not left_b) = '1' then
					       estado_sig <= Mover_der;
					   elsif (not right_b and left_b) = '1' then
					       estado_sig <= Mover_izq;
                        else
                            estado_sig <= Quieto;
                        end if;
		when Atacar
					=>	if attack_c = 55 then
                            if (right_b and not left_b) = '1' then
								estado_sig <= Mover_der;
							elsif (not right_b and left_b) = '1' then
								estado_sig <= Mover_izq;
							else
								estado_sig <= Quieto;
							end if;
						else
							estado_sig <= Atacar;
						end if;
		when Muerto
					=>	estado_sig <= Quieto;
	end case;
end process;

process (invulnerable, muerto_anim, rgb_dec)
begin
	if	invulnerable = '1' and muerto_anim = '0' and rgb_dec /= ALPHA_3 then
		rgb_personaje <= WHITE_9;
	elsif	invulnerable = '1' and muerto_anim = '1' and rgb_dec /= ALPHA_3 then
		rgb_personaje <= RED_9;
	elsif rgb_dec = RED_3 then
		rgb_personaje <= RED_9;
	elsif rgb_dec = DARK_RED_3 then
		rgb_personaje <= DARK_RED_9;
	elsif rgb_dec = SKIN_3 then
		rgb_personaje <= SKIN_9;
	elsif rgb_dec = GREY_3 then
		rgb_personaje <= GREY_9;
	elsif rgb_dec = DARK_GREY_3 then
		rgb_personaje <= DARK_GREY_9;
	elsif rgb_dec = WHITE_3 then
		rgb_personaje <= WHITE_9;
	else
		rgb_personaje <= BLACK_9;
	end if;
end process;

end Behavioral;
