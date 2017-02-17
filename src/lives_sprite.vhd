----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:56:01 12/07/2014 
-- Design Name: 
-- Module Name:    cards_sprite - Behavioral 
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

entity lives_sprite is
port
	(
		x				:	in		STD_LOGIC_VECTOR(7 downto 0);
		draw_sprite	:	out	STD_LOGIC;
		rgb			:	out	STD_LOGIC_VECTOR(8 downto 0)
	);
end lives_sprite;

architecture Behavioral of lives_sprite is
type SPRITE_PALETTE is (WHITE, BLACK, RED,ALPHA, SKIN, GREY);
type SPRITE_ROM is array (integer range <>) of SPRITE_PALETTE;
constant BLACK_9 : std_logic_vector(8 downto 0) := "000000000";
constant RED_9 : std_logic_vector(8 downto 0) := "111000000";
constant WHITE_9 : std_logic_vector(8 downto 0) := "111111111";
constant SKIN_9		: std_logic_vector(8 downto 0) := "110101100";
constant DARK_GREY_9	: std_logic_vector(8 downto 0) := "010010010";
constant sprite : SPRITE_ROM (0 to 255) := 
(ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,BLACK,GREY,BLACK,GREY,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,GREY,GREY,WHITE,WHITE,WHITE,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,WHITE,WHITE,GREY,GREY,BLACK,SKIN,SKIN,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,GREY,WHITE,BLACK,GREY,BLACK,SKIN,SKIN,BLACK,ALPHA,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,SKIN,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,BLACK,WHITE,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,BLACK,WHITE,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,RED,RED,RED,RED,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,
BLACK,BLACK,RED,RED,RED,RED,RED,BLACK,BLACK,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,
BLACK,BLACK,RED,RED,RED,RED,RED,RED,BLACK,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA);
signal rgb_dec : SPRITE_PALETTE;
begin
rgb_dec <=	sprite(to_integer(unsigned(x)));
draw_sprite <= '1' when rgb_dec /= ALPHA else '0';
rgb <=	WHITE_9 when rgb_dec = WHITE else
			RED_9 when rgb_dec = RED else
			SKIN_9 when rgb_dec = SKIN else
			DARK_GREY_9 when rgb_dec = GREY else
			BLACK_9;
end Behavioral;
