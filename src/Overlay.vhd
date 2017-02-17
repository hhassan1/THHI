----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:33:09 02/17/2015 
-- Design Name: 
-- Module Name:    Overlay - Behavioral 
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

entity overlay is
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
end overlay;

architecture Behavioral of overlay is
component BCD is
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		start : in STD_LOGIC;
		binary : in UNSIGNED(23 downto 0);
		finish : out STD_LOGIC;
		output : out UNSIGNED(27 downto 0)
	);
end component;
component overlay_sprite is
	port
	(
		x : in STD_LOGIC_VECTOR(15 downto 0);
		draw_overlay : out STD_LOGIC
	);
end component;
component digits is
	port
	(
		x : in STD_LOGIC_VECTOR(7 downto 0);
		number : in UNSIGNED(3 downto 0);
		draw_digit : out STD_LOGIC
	);
end component;
component lives_sprite is
port
	(
		x				:	in		STD_LOGIC_VECTOR(7 downto 0);
		draw_sprite	:	out	STD_LOGIC;
		rgb			:	out	STD_LOGIC_VECTOR(8 downto 0)
	);
end component;
type STATE_TYPE is (WAIT_FOR_CARD_END, START_CALCULATE, WAIT_CALCULATE);
signal state, next_state : STATE_TYPE;
signal start, finish : STD_LOGIC;
signal addr_c : unsigned(15 downto 0);
signal draw_overlay, draw_number, card_ended, draw_life, level_dec : STD_LOGIC;
signal number : UNSIGNED(3 downto 0);
signal vga_addr,l_addr : STD_LOGIC_VECTOR(7 downto 0);
signal output : UNSIGNED(27 downto 0);
signal rgb_life : STD_LOGIC_VECTOR(8 downto 0);
begin

l_sprite : lives_sprite port map (l_addr, draw_life, rgb_life);
digit_decoder : digits port map (vga_addr,number,draw_number);
over_sprite : overlay_sprite port map (std_logic_vector(addr_c), draw_overlay);
point_bcd : BCD port map (clk,reset,start,points,finish,output);
vga_addr <= std_logic_vector(resize(vga_x(3 downto 0) + (vga_y(4 downto 0))*13,8)) when vga_x < 368 else
				std_logic_vector(resize(vga_x(3 downto 0) + (vga_y(5 downto 0) - 33)*13,8));
l_addr <= std_logic_vector(vga_y(3 downto 0)) & std_logic_vector(vga_x(3 downto 0));
draw_sprite <= '1' when vga_x >= 64 and vga_x < 320 and vga_y >= 128 and vga_y < 352 and interleave = '1' else
					draw_life when level_dec = '1' and vga_x >= 128 and vga_x < 224 and vga_y < 16 else
					draw_number when (( interleave = '0' and  vga_x >= 256 and vga_x < 368 and vga_y < 14 ) or (vga_x >= 608 and vga_x < 624 and vga_y >= 33 and vga_y < 47)) else
					draw_overlay;
rgb <= "111111111" when vga_x >= 208 and vga_x < 320 and vga_y >= 160 and vga_y < 174 and draw_number = '1' else
		 "100100100" when vga_x >= 64 and vga_x < 320 and vga_y >= 128 and vga_y < 352 else
		 rgb_life when vga_x >= 128 and vga_x < 224 and vga_y < 16 and level_dec = '1' else
		 "111111111" when interleave = '0' and ((vga_x >= 256 and vga_x < 368 and vga_y < 14) or (vga_x >= 608 and vga_x < 624 and vga_y >= 33 and vga_y < 47)) else
		 "111000000";
		 
level_dec <= '1' when lives = 7 else
				 '1' when lives = 6 and vga_x(7 downto 4) < 14 else
				 '1' when lives = 5 and vga_x(7 downto 4) < 13 else
				 '1' when lives = 4 and vga_x(7 downto 4) < 12 else
				 '1' when lives = 3 and vga_x(7 downto 4) < 11 else
				 '1' when lives = 2 and vga_x(7 downto 4) < 10 else
				 '1' when lives = 1 and vga_x(7 downto 4) < 9 else
				 '0';
start <= '1' when state = START_CALCULATE else '0';
card_ended <= '1' when vga_x = 0 and vga_y = 500 else '0';
number <= "1111" when vga_x(3 downto 0) > 12 else
			 output(27 downto 24) when (vga_x < 272 and interleave = '0') or (vga_x < 224 and interleave = '1') else
			 output(23 downto 20) when (vga_x < 288 and interleave = '0') or (vga_x < 240 and interleave = '1') else
			 output(19 downto 16) when (vga_x < 304 and interleave = '0') or (vga_x < 256 and interleave = '1') else
			 output(15 downto 12) when (vga_x < 320 and interleave = '0') or (vga_x < 272 and interleave = '1') else
			 output(11 downto 8) when (vga_x < 336 and interleave = '0') or (vga_x < 288 and interleave = '1') else
			 output(7 downto 4) when (vga_x < 352 and interleave = '0') or (vga_x < 304 and interleave = '1') else
			 output(3 downto 0) when (vga_x < 368 and interleave = '0') or (vga_x < 320 and interleave = '1') else
			 resize(level,4);
			 
process(reset,clk)
begin
	if reset = '1' then
		state <= WAIT_FOR_CARD_END;
		addr_c <= (others => '0');
	elsif rising_edge(clk) then
		state <= next_state;
		if vga_x = 799 and vga_y = 524 then
			addr_c <= (others => '0');
		elsif vga_x < 640 and vga_y < 64 then
			addr_c <= addr_c + 1;
		end if;
	end if;
end process;
process(state, card_ended, finish)
begin
	case state is
		when WAIT_FOR_CARD_END
			=> if card_ended = '1' then
					next_state <= START_CALCULATE;
				else
					next_state <= WAIT_FOR_CARD_END;
				end if;
		when START_CALCULATE
			=> next_state <= WAIT_CALCULATE;
		when WAIT_CALCULATE
			=>	if finish = '1' then
					next_state <= WAIT_FOR_CARD_END;
				else
					next_state <= WAIT_CALCULATE;
				end if;
	end case;
end process;

end Behavioral;

