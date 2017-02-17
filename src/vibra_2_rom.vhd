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

entity vibra_2_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(5 downto 0);
			d_out: out UNSIGNED(14 downto 0));
end vibra_2_rom;

architecture Behavioral of vibra_2_rom is
type rom_type_word8 is array (integer range <>) of std_logic_vector(2 downto 0);
constant rom_vibra : rom_type_word8(0 to 63) :=
(	"000","010","011","100","011","010","101","100",
	"011","010","001","010","110","011","100","111",
	"000","010","011","100","011","010","101","100",
	"011","010","000","011","100","101","110","111",
	"000","010","011","100","011","010","000","101",
	"100","011","100","100","011","101","110","111",
	"110","101","100","100","011","010","000","101",
	"100","011","010","010","000","011","100","111");
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
-- 100MHz
--d_out <=	to_unsigned(26813,d_out'length) when note_vibra = "000" else
--			to_unsigned(22547,d_out'length) when note_vibra = "001" else
--			to_unsigned(20087,d_out'length) when note_vibra = "010" else
--			to_unsigned(17895,d_out'length) when note_vibra = "011" else
--			to_unsigned(16891,d_out'length) when note_vibra = "100" else
--			to_unsigned(15048,d_out'length) when note_vibra = "101" else
--			to_unsigned(13406,d_out'length) when note_vibra = "110" else
--			to_unsigned(0,d_out'length);
-- 50MHz
d_out <=	to_unsigned(13406,d_out'length) when note_vibra = "000" else
			to_unsigned(11273,d_out'length) when note_vibra = "001" else
			to_unsigned(10043,d_out'length) when note_vibra = "010" else
			to_unsigned(8947,d_out'length) when note_vibra = "011" else
			to_unsigned(8445,d_out'length) when note_vibra = "100" else
			to_unsigned(7523,d_out'length) when note_vibra = "101" else
			to_unsigned(6702,d_out'length) when note_vibra = "110" else
			to_unsigned(0,d_out'length);
end Behavioral;

