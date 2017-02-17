----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:08:36 03/13/2015 
-- Design Name: 
-- Module Name:    startscreen - Behavioral 
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


entity startscreen is
	port
	(
		vga_x		:	in UNSIGNED(9 downto 0);
		vga_y		:	in UNSIGNED(9 downto 0);
		draw_sprite	:	out STD_LOGIC
	);
end startscreen;

architecture Behavioral of startscreen is
type START_ROM is array(0 to 299) of STD_LOGIC;
constant rom : START_ROM :=(
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1',
'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1',
'0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1',
'0','0','1','1','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1',
'0','0','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1',
'0','0','1','1','1','0','1','0','1','0','1','0','1','0','1','0','0','0','1','1',
'0','0','0','1','0','0','1','1','1','0','1','0','0','0','1','1','0','1','1','1',
'0','0','0','1','0','0','1','0','1','0','1','0','1','0','1','0','0','0','1','1',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1',
'0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','1','1',
'0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','1','1',
'0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1',
'0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1',
'0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1');
begin
draw_sprite <= rom(to_integer(vga_x(9 downto 5) + (unsigned(std_logic_vector(vga_y(9 downto 5)) & "0000")) + (unsigned(std_logic_vector(vga_y(9 downto 5)) & "00"))));

end Behavioral;