----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.12.2014 13:06:37
-- Design Name: 
-- Module Name: player_sprite_attack_2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.Types.ALL;

entity player_sprite_attack_3 is
	port
(
    x    : in STD_LOGIC_VECTOR(10 downto 0);
    colour    :    out STD_LOGIC_VECTOR(2 downto 0)
);
end player_sprite_attack_3;

architecture Behavioral of player_sprite_attack_3 is
type SPRITE_ROM is array(integer range <>) of STD_LOGIC_VECTOR(2 downto 0);
constant BLACK : std_logic_vector(2 downto 0) := BLACK_3;
constant RED : std_logic_vector(2 downto 0) := RED_3; 
constant DARK_RED : std_logic_vector(2 downto 0) := DARK_RED_3;
constant SKIN : std_logic_vector(2 downto 0) := SKIN_3;
constant GREY : std_logic_vector(2 downto 0) := GREY_3;
constant DARK_GREY : std_logic_vector(2 downto 0) := DARK_GREY_3;
constant WHITE : std_logic_vector(2 downto 0) := WHITE_3;
constant ALPHA : std_logic_vector(2 downto 0) := ALPHA_3;
constant rom : SPRITE_ROM(0 to 1763) := 
(BLACK,DARK_RED,DARK_GREY,WHITE,WHITE,WHITE,WHITE,WHITE,DARK_RED,BLACK,DARK_GREY,BLACK,BLACK,BLACK,DARK_RED,DARK_RED,DARK_RED,DARK_GREY,WHITE,WHITE,WHITE,WHITE,DARK_GREY,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
BLACK,DARK_RED,DARK_RED,RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_GREY,DARK_RED,BLACK,BLACK,DARK_RED,DARK_RED,DARK_RED,RED,DARK_RED,DARK_RED,DARK_RED,DARK_GREY,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
BLACK,DARK_GREY,DARK_RED,DARK_RED,RED,RED,RED,DARK_RED,DARK_RED,DARK_RED,BLACK,DARK_RED,DARK_RED,DARK_RED,DARK_RED,RED,RED,RED,RED,DARK_RED,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
BLACK,DARK_RED,DARK_RED,RED,RED,RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,RED,RED,RED,RED,RED,DARK_RED,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
BLACK,BLACK,DARK_RED,DARK_RED,RED,RED,RED,DARK_RED,RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,RED,DARK_RED,RED,DARK_RED,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
BLACK,BLACK,BLACK,DARK_RED,DARK_RED,RED,RED,RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,BLACK,DARK_RED,DARK_GREY,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,BLACK,BLACK,BLACK,DARK_RED,DARK_RED,DARK_RED,DARK_RED,DARK_RED,BLACK,DARK_RED,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,ALPHA,BLACK,BLACK,DARK_RED,DARK_RED,BLACK,DARK_RED,BLACK,BLACK,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,BLACK,DARK_RED,BLACK,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,DARK_GREY,WHITE,WHITE,WHITE,WHITE,WHITE,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,WHITE,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
BLACK,BLACK,BLACK,DARK_RED,BLACK,BLACK,DARK_RED,BLACK,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,DARK_GREY,DARK_GREY,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,BLACK,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,
BLACK,DARK_RED,RED,DARK_GREY,RED,BLACK,BLACK,DARK_GREY,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,SKIN,GREY,WHITE,WHITE,WHITE,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,
BLACK,DARK_GREY,DARK_RED,DARK_RED,DARK_RED,RED,DARK_RED,BLACK,BLACK,DARK_GREY,DARK_GREY,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,WHITE,GREY,SKIN,SKIN,SKIN,SKIN,SKIN,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,BLACK,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
BLACK,DARK_RED,DARK_RED,RED,RED,DARK_RED,DARK_GREY,BLACK,ALPHA,BLACK,BLACK,BLACK,WHITE,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,SKIN,SKIN,SKIN,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
ALPHA,BLACK,DARK_RED,RED,DARK_RED,DARK_RED,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
ALPHA,BLACK,BLACK,BLACK,BLACK,DARK_RED,BLACK,BLACK,ALPHA,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,DARK_GREY,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,DARK_GREY,WHITE,WHITE,WHITE,WHITE,DARK_GREY,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_RED,DARK_GREY,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,WHITE,WHITE,WHITE,DARK_GREY,BLACK,BLACK,BLACK,DARK_RED,DARK_RED,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
ALPHA,BLACK,ALPHA,BLACK,ALPHA,ALPHA,ALPHA,BLACK,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,WHITE,WHITE,WHITE,WHITE,DARK_GREY,DARK_GREY,BLACK,DARK_RED,DARK_RED,DARK_RED,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,WHITE,WHITE,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,WHITE,WHITE,WHITE,DARK_GREY,DARK_GREY,BLACK,DARK_RED,RED,RED,RED,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,WHITE,WHITE,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,BLACK,DARK_GREY,DARK_GREY,DARK_GREY,BLACK,BLACK,DARK_RED,DARK_RED,RED,RED,DARK_RED,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,WHITE,
BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,WHITE,WHITE,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,DARK_GREY,BLACK,DARK_GREY,DARK_GREY,BLACK,RED,RED,RED,RED,DARK_GREY,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,
BLACK,DARK_GREY,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,DARK_GREY,DARK_RED,DARK_RED,DARK_RED,RED,RED,DARK_RED,DARK_RED,DARK_RED,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,WHITE,WHITE,
BLACK,DARK_GREY,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,BLACK,DARK_GREY,DARK_RED,DARK_GREY,DARK_RED,DARK_RED,RED,RED,RED,DARK_RED,BLACK,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,WHITE,WHITE,ALPHA,
BLACK,DARK_GREY,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,DARK_RED,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,BLACK,BLACK,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,BLACK,ALPHA,ALPHA,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,ALPHA,WHITE,WHITE,WHITE,
ALPHA,ALPHA,BLACK,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,WHITE,WHITE,
ALPHA,ALPHA,ALPHA,BLACK,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,BLACK,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,WHITE,WHITE,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,WHITE,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,
ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,WHITE,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA,ALPHA);

begin
		colour <= rom(to_integer(unsigned(x)))
--pragma synthesis_off
		when unsigned(x) < 1764 else ALPHA
--pragma synthesis_on
		;
end Behavioral;
