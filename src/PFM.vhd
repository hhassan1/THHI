----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:24:35 01/03/2015 
-- Design Name: 
-- Module Name:    PFM - Behavioral 
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

entity PFM is
	 Generic ( n : natural := 1);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           limit : in  UNSIGNED(n - 1 downto 0);
           clk_out : out  STD_LOGIC);
end PFM;

architecture Behavioral of PFM is
signal counter : UNSIGNED(n - 1 downto 0);
signal aux : STD_LOGIC := '0';
begin
process(clk,reset)
begin
	if reset = '1' then
		counter <= (others => '0');
	elsif rising_edge(clk) then
		if counter >= limit then
			counter <= (others => '0');
			aux <= not aux;
		else
			counter <= counter + 1;
		end if;
	end if;
end process;
clk_out <= aux;
end Behavioral;

