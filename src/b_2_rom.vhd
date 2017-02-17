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

entity bass_2_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(3 downto 0);
			d_out: out UNSIGNED(17 downto 0));
end bass_2_rom;

architecture Behavioral of bass_2_rom is
type rom_type_word4 is array (integer range <>) of std_logic_vector(1 downto 0);
constant rom_bass_2 : rom_type_word4(0 to 15) := 
("10","10","01","01","00","00","01","01","00","00","01","01","11","11","00","01");
signal note_bass_2 : STD_LOGIC_VECTOR(1 downto 0);
begin
process(clk)
begin
	if rising_edge(clk) then
		if en = '1' then
			note_bass_2 <= rom_bass_2(to_integer(addr));
		end if;
	end if;
end process;
-- 100MHz
--d_out <=	to_unsigned(143171,d_out'length) when note_bass_2 = "00" else
--			to_unsigned(127550,d_out'length) when note_bass_2 = "01" else
--			to_unsigned(113635,d_out'length) when note_bass_2 = "10" else
--			to_unsigned(95555,d_out'length);
-- 50MHz
d_out <=	to_unsigned(71585,d_out'length) when note_bass_2 = "00" else
			to_unsigned(63774,d_out'length) when note_bass_2 = "01" else
			to_unsigned(56817,d_out'length) when note_bass_2 = "10" else
			to_unsigned(47777,d_out'length);
end Behavioral;

