----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:09:14 02/16/2015 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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

entity RAM is
	port
	(
		clk : in STD_LOGIC;
		addr : in STD_LOGIC_VECTOR(7 downto 0);
		din : in UNSIGNED(4 downto 0);
		we : in STD_LOGIC;
		dout : out UNSIGNED(4 downto 0)
	);
end RAM;

architecture Behavioral of RAM is
type mem is array (0 to 255) of UNSIGNED(4 downto 0);
signal memory : mem;
begin
process(clk)
begin
	if rising_edge(clk) then
		dout <= memory(to_integer(unsigned(addr)));
		if we = '1' then
			memory(to_integer(unsigned(addr))) <= din;
		end if;
	end if;
end process;
end Behavioral;

