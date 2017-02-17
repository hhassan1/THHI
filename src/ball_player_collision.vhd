----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:55:26 12/13/2014 
-- Design Name: 
-- Module Name:    ball_player_collision - Behavioral 
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

entity ball_player_collision is
	port
	(
		attack : in STD_LOGIC;
		player_x : in UNSIGNED(9 downto 0);
		player_y : in UNSIGNED(9 downto 0);
		ball_x : in UNSIGNED(9 downto 0);
		ball_y : in UNSIGNED(8 downto 0);
		collision : out STD_LOGIC
	);
end ball_player_collision;

architecture Behavioral of ball_player_collision is

begin
collision <=	'1' when (player_x <= ball_x + 20 and ball_x < player_x + 20 and ball_y > player_y - 30) and attack = '0' else
					'1' when (player_x <= ball_x + 25 and ball_x < player_x + 42 and ball_y > player_y - 67) and attack = '1' else
					'0';				
--collision <= '1' when (sprite = STILL) and (player_x <= ball_x + 19 and ball_x < player_x + 15 and player_y >= ball_y + 12 and ball_y + 40 > player_y) else
--				'1' when (sprite = MOVEMENT_1_LEFT or sprite = MOVEMENT_1_RIGHT) and (player_x <= ball_x + 16 and ball_x < player_x + 19 and player_y >= ball_y + 11 and ball_y + 44 > player_y) else
--				'1' when (sprite = MOVEMENT_2_LEFT or sprite = MOVEMENT_2_RIGHT) and (player_x <= ball_x + 17 and ball_x < player_x + 18 and player_y >= ball_y + 8 and ball_y + 41 > player_y) else
--				'0';
end Behavioral;