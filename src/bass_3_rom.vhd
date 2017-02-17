----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:42 01/03/2015 
-- Design Name: 
-- Module Name:    bass_1_rom - Behavioral 
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

entity bass_3_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(3 downto 0);
			d_out: out UNSIGNED(15 downto 0));
end bass_3_rom;

architecture Behavioral of bass_3_rom is
type rom_type_word4 is array (integer range <>) of std_logic_vector(1 downto 0);
constant rom_bass_1 : rom_type_word4(0 to 15) := 
("00","00","00","00","01","01","01","01","10","10","10","10","00","00","00","00");
signal note_bass_1 : STD_LOGIC_VECTOR(1 downto 0);
begin
process(clk)
begin
	if rising_edge(clk) then
		if en = '1' then
			note_bass_1 <= rom_bass_1(to_integer(addr));
		end if;
	end if;
end process;
-- 100MHz
--d_out <=	to_unsigned(53628,d_out'length) when note_bass_1 = "00" else
--			to_unsigned(40175,d_out'length) when note_bass_1 = "01" else
--			to_unsigned(35792,d_out'length) when note_bass_1 = "10" else
--			to_unsigned(0,d_out'length);
-- 50MHz
d_out <=	to_unsigned(26813,d_out'length) when note_bass_1 = "00" else
			to_unsigned(20087,d_out'length) when note_bass_1 = "01" else
			to_unsigned(17895,d_out'length) when note_bass_1 = "10" else
			to_unsigned(0,d_out'length);
end Behavioral;
