----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:42:47 12/07/2014 
-- Design Name: 
-- Module Name:    random_bit_gen - Behavioral 
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

entity random_bit_gen is
	port
	(
		clk	:	in	STD_LOGIC;
		rng:	out STD_LOGIC
	);
end random_bit_gen;

architecture Behavioral of random_bit_gen is
signal pipeline : STD_LOGIC_VECTOR(11 downto 0) := "011000011000";
begin

process (clk, pipeline)
begin
	if rising_edge(clk) then
		pipeline <= pipeline(10 downto 0) & (((pipeline(11) xor pipeline(5)) xor pipeline(3)) xor pipeline(0));
	end if;
end process;
rng <= pipeline(11);
end Behavioral;

