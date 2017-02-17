library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Types.ALL;

entity bola is
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
end bola;

architecture Behavioral of bola is
component ball_sprite is port (x : in STD_LOGIC_VECTOR(9 downto 0); colour	:	out STD_LOGIC_VECTOR(1 downto 0));end component;
CONSTANT VELOCIDAD_INICIAL_X: INTEGER := -3;
CONSTANT VELOCIDAD_INICIAL_Y: INTEGER := 3;
CONSTANT GRAVEDAD: INTEGER := 1;
CONSTANT FUERZA_X: INTEGER := 5;
CONSTANT FUERZA_Y: INTEGER := 25;
CONSTANT POSICION_INICIAL_X : INTEGER :=600;
CONSTANT POSICION_INICIAL_Y : INTEGER :=200;
CONSTANT RECTANGULO_VMIN: INTEGER := 64;
CONSTANT RECTANGULO_VMAX: INTEGER := 479;
CONSTANT RECTANGULO_HMIN: INTEGER := 0;
CONSTANT RECTANGULO_HMAX: INTEGER := 639;
constant p_height : natural := 25;
constant p_width : natural := 25;

type EstadoBola is (Inicio, Mover, Atacado, Invulnerable);
signal estado, estado_sig :EstadoBola;
signal px,r_px: unsigned(9 downto 0);
signal py,r_py: unsigned(8 downto 0);
signal vx,vy,r_vx,r_vy: signed(10 downto 0);
signal rgb_dec, colour_ball : std_logic_vector(1 downto 0);
signal x_sprite : STD_LOGIC_VECTOR(9 downto 0);
signal anim_c : unsigned(5 downto 0);
begin

process(rst,clk)
begin
		if rst ='1' then
			estado <= Inicio;
			r_px <= to_unsigned(posicion_inicial_x,px'length);
			r_py <= to_unsigned(posicion_inicial_y,py'length);
			r_vx <= to_signed(velocidad_inicial_x,vx'length);
			r_vy <= to_signed(velocidad_inicial_y,vy'length);
			anim_c <= (others => '0');
		elsif rising_edge(clk) then
			estado<=estado_sig;
			r_px<=px;
			r_py<=py;
			r_vx<=vx;
			r_vy<=vy;
			if estado /= Inicio then
				if r_vx < 0 then
					anim_c <= anim_c + 1;
				elsif r_vx > 0 then
					anim_c <= anim_c - 1;
				end if;
			end if;
		end if;
end process;

process (estado, start_b, col_per, ataca)
begin
	case estado is
		when Inicio	=>	
					if start_b = '1' then
						estado_sig <= Mover;
					else
						estado_sig <= Inicio;
					end if;
		when Mover =>
					if col_per ='1' and ataca='1' then
						estado_sig<=Atacado;
					else
						estado_sig<=Mover;
					end if;
		when Atacado|Invulnerable =>
		            if col_per ='1' and ataca='1' then
					   estado_sig<=Invulnerable;
					else
					   estado_sig <= Mover;
					end if; 
	end case;
end process;

px	<=	to_unsigned(rectangulo_hmax-p_width, px'length) when (estado = MOVER or estado = Invulnerable) and (to_integer(r_px) + to_integer(r_vx) > rectangulo_hmax - p_width) else
		to_unsigned(rectangulo_hmin,px'length) when (estado = MOVER or estado = Invulnerable) and (to_integer(r_px) + to_integer(r_vx) < rectangulo_hmin) else
		to_unsigned(to_integer(r_px)+to_integer(r_vx),px'length) when estado = MOVER else
		r_px;
py	<=	to_unsigned(rectangulo_vmax-p_height,py'length) when (estado = MOVER or estado = Invulnerable) and (to_integer(r_py) + to_integer(r_vy) > rectangulo_vmax - p_height) else
		to_unsigned(rectangulo_vmin,py'length) when (estado = MOVER or estado = Invulnerable) and (to_integer(r_py) + to_integer(r_vy) < rectangulo_vmin) else
		to_unsigned(to_integer(r_py)+to_integer(r_vy),py'length) when (estado = MOVER or estado = Invulnerable) else
		r_py;
vx	<=	resize(-(r_vx*3)/4,11) when (estado = MOVER or estado = Invulnerable) and ((to_integer(r_px) + to_integer(r_vx) > rectangulo_hmax - p_width) or (to_integer(r_px) + to_integer(r_vx) < rectangulo_hmin)) else
		(-r_vx)+fuerza_x when estado = ATACADO and r_vx < 0 else
		(-r_vx)-fuerza_x when estado = ATACADO else
		r_vx;
vy	<=  (others => '0') when (estado = MOVER or estado = Invulnerable) and (to_integer(r_py) + to_integer(r_vy) > rectangulo_vmax - p_height) and r_vy <= 4 else
        resize(-(r_vy*3)/4,11) when (estado = MOVER or estado = Invulnerable) and ((to_integer(r_py) + to_integer(r_vy) > rectangulo_vmax - p_height) or (to_integer(r_py) + to_integer(r_vy) < rectangulo_vmin)) else
		r_vy + gravedad when (estado = MOVER or estado = Invulnerable) else
		r_vy - fuerza_y when estado = ATACADO and r_vy < 0 else
		-r_vy - fuerza_y when estado = ATACADO else
		r_vy;
x_sprite <= std_logic_vector(resize(25 - (vga_x - r_px),5)) & std_logic_vector(resize(vga_y - r_py,5)) when anim_c >= 48 else
				std_logic_vector(resize(25 - (vga_y - r_py),5)) & std_logic_vector(resize(25 - (vga_x - r_px),5)) when anim_c >= 32 else
				std_logic_vector(resize(vga_x - r_px,5)) & std_logic_vector(resize(25 - (vga_y - r_py),5)) when anim_c >= 16 else
				std_logic_vector(resize(vga_y - r_py,5)) & std_logic_vector(resize(vga_x - r_px,5));
ball_spr : ball_sprite port map (x_sprite, colour_ball);
rgb_dec <=	colour_ball when r_px <= vga_x and vga_x < r_px+p_width and r_py <= vga_y and vga_y < r_py+p_height else
				ALPHA_2;
pos_x <= r_px;
pos_y <= r_py;

rgb_bola <= BLACK_9 when rgb_dec = BLACK_2 else
				WHITE_9 when rgb_dec = WHITE_2 else
				DARK_GREY_9 when rgb_dec = GREY_2 else
				BLACK_9;
pinta_bola <= '1' when rgb_dec /= ALPHA_2 else '0';

end Behavioral;