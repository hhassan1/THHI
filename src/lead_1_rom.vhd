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

entity lead_1_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(4 downto 0);
			d_out: out UNSIGNED(15 downto 0));
end lead_1_rom;

architecture Behavioral of lead_1_rom is
type rom_type_word8 is array (integer range <>) of std_logic_vector(2 downto 0);
constant rom_vibra : rom_type_word8(0 to 31) :=
("001","101","001","100","011","010","001","101","100","011","010","000","100","011","110","101",
 "001","010","011","001","101","100","011","100","101","001","100","001","011","001","010","001");
signal note_vibra : std_logic_vector(2 downto 0);
begin
process(clk)
begin
	if rising_edge(clk) then
		if en = '1' then
			note_vibra <= rom_vibra(to_integer(addr));
		end if;
	end if;
end process;
d_out <=	to_unsigned(47777,d_out'length) when note_vibra = "000" else
			to_unsigned(42564,d_out'length) when note_vibra = "001" else
			to_unsigned(37920,d_out'length) when note_vibra = "010" else
			to_unsigned(35792,d_out'length) when note_vibra = "011" else
			to_unsigned(31887,d_out'length) when note_vibra = "100" else
			to_unsigned(28408,d_out'length) when note_vibra = "101" else
			to_unsigned(23888,d_out'length);
end Behavioral;
