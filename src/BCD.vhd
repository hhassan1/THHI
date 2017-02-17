----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:04:55 02/17/2015 
-- Design Name: 
-- Module Name:    BCD - Behavioral 
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

entity BCD is
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		start : in STD_LOGIC;
		binary : in UNSIGNED(23 downto 0);
		finish : out STD_LOGIC;
		output : out UNSIGNED(27 downto 0)
	);
end BCD;

architecture Behavioral of BCD is
type STATE_TYPE is (IDLE, SET_UP, SHIFT, ADD);
signal state, next_state : STATE_TYPE;
signal work_reg, work_reg_next : UNSIGNED(51 downto 0);
signal counter : UNSIGNED(4 downto 0);
begin

finish <= '1' when state = IDLE else '0';
output <= work_reg(51 downto 24);

process(reset, clk)
begin
	if reset = '1' then
		state <= IDLE;
		work_reg <= (others => '0');
		counter <= (others => '0');
	elsif rising_edge(clk) then
		state <= next_state;
		if state = SHIFT then
			counter <= counter + 1;
		elsif state = IDLE then
			counter <= (others => '0');
		end if;
		work_reg <= work_reg_next;
	end if;
end process;
process(state,start,counter)
begin
	case state is
		when IDLE
			=> if start = '1' then
					next_state <= SET_UP;
				else
					next_state <= IDLE;
				end if;
		when SHIFT
			=> if counter = 23 then
					next_state <= IDLE;
				else
					next_state <= ADD;
				end if;
		when ADD
			=> next_state <= SHIFT;
		when SET_UP
			=> next_state <= SHIFT;
	end case;
end process;
process(state, work_reg, binary)
begin
	work_reg_next <= work_reg;
	if state = SHIFT then
		work_reg_next <= work_reg(work_reg'left - 1 downto 0) & '0';
	elsif state = ADD then
		if work_reg(51 downto 48) > 4 then
			work_reg_next(51 downto 48) <= work_reg(51 downto 48) + 3;
		end if;
		if work_reg(47 downto 44) > 4 then
			work_reg_next(47 downto 44) <= work_reg(47 downto 44) + 3;
		end if;
		if work_reg(43 downto 40) > 4 then
			work_reg_next(43 downto 40) <= work_reg(43 downto 40) + 3;
		end if;
		if work_reg(39 downto 36) > 4 then
			work_reg_next(39 downto 36) <= work_reg(39 downto 36) + 3;
		end if;
		if work_reg(35 downto 32) > 4 then
			work_reg_next(35 downto 32) <= work_reg(35 downto 32) + 3;
		end if;
		if work_reg(31 downto 28) > 4 then
			work_reg_next(31 downto 28) <= work_reg(31 downto 28) + 3;
		end if;
		if work_reg(27 downto 24) > 4 then
			work_reg_next(27 downto 24) <= work_reg(27 downto 24) + 3;
		end if;
	elsif state = SET_UP then
		work_reg_next(51 downto 24) <= (others => '0');
	else
		work_reg_next(23 downto 0) <= binary;
	end if;
end process;
end Behavioral;