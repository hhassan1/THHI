----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:00:58 02/17/2015 
-- Design Name: 
-- Module Name:    digits - Behavioral 
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

entity digits is
	port
	(
		x : in STD_LOGIC_VECTOR(7 downto 0);
		number : in UNSIGNED(3 downto 0);
		draw_digit : out STD_LOGIC
	);
end digits;

architecture Behavioral of digits is
type digit is array(0 to 181) of STD_LOGIC;
constant d_0 : digit := 
('0','0','1','1','1','1','1','1','1','1','0','0','0',
'0','1','1','1','0','0','0','0','1','1','1','0','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'0','1','1','1','0','0','0','0','1','1','1','0','0',
'0','0','1','1','1','1','1','1','1','1','0','0','0');
constant d_1 : digit :=
('0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','1','1','1','1','0','0','0','0','0',
'0','0','0','1','1','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','1','1','1','1','1','0','0','0','0');
constant d_2 : digit :=
('0','0','0','1','1','1','1','1','1','1','0','0','0',
'0','1','1','1','1','0','0','0','1','1','1','1','0',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'0','0','0','0','0','0','0','0','0','0','1','1','1',
'0','0','0','0','0','0','0','0','1','1','1','1','0',
'0','0','0','0','0','1','1','1','1','1','0','0','0',
'0','0','0','1','1','1','1','0','0','0','0','0','0',
'0','0','1','1','1','0','0','0','0','0','0','0','0',
'0','1','1','1','0','0','0','0','0','0','0','0','0',
'0','1','1','1','0','0','0','0','0','0','0','0','0',
'1','1','1','0','0','0','0','0','0','0','0','0','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1');
constant d_3 : digit :=
('0','0','0','1','1','1','1','1','1','1','0','0','0',
'0','1','1','1','1','0','0','0','1','1','1','1','0',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'0','0','0','0','0','0','0','0','0','0','1','1','1',
'0','0','0','0','0','0','0','0','0','1','1','1','0',
'0','0','0','1','1','1','1','1','1','1','0','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','0',
'0','0','0','0','0','0','0','0','0','0','1','1','1',
'0','0','0','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'0','1','1','1','1','0','0','0','1','1','1','1','0',
'0','0','0','1','1','1','1','1','1','1','0','0','0');
constant d_4 : digit :=
('0','0','0','0','0','0','0','0','1','1','1','0','0',
'0','0','0','0','0','0','0','1','1','1','1','0','0',
'0','0','0','0','0','0','1','1','1','1','1','0','0',
'0','0','0','0','0','1','1','0','1','1','1','0','0',
'0','0','0','0','0','1','1','0','1','1','1','0','0',
'0','0','0','0','1','1','1','0','1','1','1','0','0',
'0','0','0','1','1','1','0','0','1','1','1','0','0',
'0','0','1','1','1','0','0','0','1','1','1','0','0',
'0','1','1','1','0','0','0','0','1','1','1','0','0',
'1','1','1','0','0','0','0','0','1','1','1','0','0',
'1','1','1','1','1','1','1','1','1','1','1','1','1',
'0','0','0','0','0','0','0','0','1','1','1','0','0',
'0','0','0','0','0','0','0','0','1','1','1','0','0',
'0','0','0','0','0','0','0','0','1','1','1','0','0');
constant d_5 : digit :=
('1','1','1','1','1','1','1','1','1','1','1','0','0',
'1','1','1','0','0','0','0','0','0','0','0','0','0',
'1','1','1','0','0','0','0','0','0','0','0','0','0',
'1','1','1','0','0','0','0','0','0','0','0','0','0',
'1','1','1','1','1','1','1','1','0','0','0','0','0',
'1','1','1','1','0','0','1','1','1','1','0','0','0',
'1','1','1','0','0','0','0','0','1','1','1','0','0',
'0','0','0','0','0','0','0','0','1','1','1','0','0',
'0','0','0','0','0','0','0','0','0','1','1','1','0',
'0','0','0','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','1','1','1','0','0',
'1','1','1','0','0','0','0','0','1','1','1','0','0',
'0','1','1','1','1','0','1','1','1','1','0','0','0',
'0','0','0','1','1','1','1','1','0','0','0','0','0');
constant d_6 : digit :=
('0','0','0','1','1','1','1','1','1','1','0','0','0',
'0','0','1','1','1','0','0','0','1','1','1','0','0',
'0','1','1','1','0','0','0','0','0','1','1','1','0',
'0','1','1','1','0','0','0','0','0','0','0','0','0',
'1','1','1','0','1','1','1','1','1','0','0','0','0',
'1','1','1','1','1','1','0','1','1','1','1','0','0',
'1','1','1','1','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'0','1','1','1','0','0','0','0','0','1','1','1','0',
'0','1','1','1','0','0','0','0','0','1','1','1','0',
'0','0','1','1','1','1','0','1','1','1','1','0','0',
'0','0','0','0','1','1','1','1','1','0','0','0','0');
constant d_7 : digit :=
('1','1','1','1','1','1','1','1','1','1','1','1','1',
'0','0','0','0','0','0','0','0','0','0','1','1','1',
'0','0','0','0','0','0','0','0','0','1','1','1','0',
'0','0','0','0','0','0','0','0','1','1','1','0','0',
'0','0','0','0','0','0','0','1','1','1','0','0','0',
'0','0','0','0','0','0','0','1','1','1','0','0','0',
'0','0','0','0','0','0','1','1','1','0','0','0','0',
'0','0','0','0','0','0','1','1','1','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0',
'0','0','0','0','0','1','1','1','0','0','0','0','0');

constant d_8 : digit :=
('0','0','0','1','1','1','1','1','1','1','0','0','0',
'0','1','1','1','1','0','0','0','1','1','1','1','0',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'0','1','1','1','1','0','0','0','1','1','1','1','0',
'0','0','0','1','1','1','1','1','1','1','0','0','0',
'0','1','1','1','1','0','0','0','1','1','1','1','0',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'0','1','1','1','1','0','0','0','1','1','1','1','0',
'0','0','0','1','1','1','1','1','1','1','0','0','0');
constant d_9 : digit :=
('0','0','0','0','1','1','1','1','1','0','0','0','0',
'0','0','1','1','1','1','0','1','1','1','1','0','0',
'0','1','1','1','0','0','0','0','0','1','1','1','0',
'0','1','1','1','0','0','0','0','0','1','1','1','0',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'1','1','1','0','0','0','0','0','0','0','1','1','1',
'0','1','1','1','0','0','0','0','0','0','1','1','1',
'0','1','1','1','0','0','0','0','0','1','1','1','1',
'0','0','1','1','1','1','0','1','1','1','1','1','1',
'0','0','0','0','1','1','1','1','1','0','1','1','1',
'0','0','0','0','0','0','0','0','0','1','1','1','0',
'0','1','1','1','0','0','0','0','0','1','1','1','0',
'0','0','1','1','1','0','0','0','1','1','1','0','0',
'0','0','0','1','1','1','1','1','1','1','0','0','0');
signal s_0,s_1,s_2,s_3,s_4,s_5,s_6,s_7,s_8,s_9 : STD_LOGIC;
begin

draw_digit <=	s_0 when number = 0 else
					s_1 when number = 1 else
					s_2 when number = 2 else
					s_3 when number = 3 else
					s_4 when number = 4 else
					s_5 when number = 5 else
					s_6 when number = 6 else
					s_7 when number = 7 else
					s_8 when number = 8 else
					s_9 when number = 9 else
					'0';
s_0 <= d_0(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_1 <= d_1(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_2 <= d_2(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_3 <= d_3(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_4 <= d_4(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_5 <= d_5(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_6 <= d_6(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_7 <= d_7(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_8 <= d_8(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
s_9 <= d_9(to_integer(unsigned(x)))
	-- pragma synthesis_off
		 when unsigned(x) < 182 else '0'
	-- pragma synthesis_on
	;
end Behavioral;