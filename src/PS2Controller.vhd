----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:56:37 11/03/2014 
-- Design Name: 
-- Module Name:    PS2Controller - Behavioral 
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

entity PS2Controller is
	port
	(
		clk				:	in  STD_LOGIC;
		reset				:	in  STD_LOGIC;
		ps2_clk			:	in  STD_LOGIC;
		ps2_data			:	in  STD_LOGIC;
		scancode			:	out STD_LOGIC_VECTOR (7 downto 0);
		transmiting		:	out STD_LOGIC;
		data_received	:	out STD_LOGIC;
		error				:	out STD_LOGIC
			  );
end PS2Controller;

architecture Behavioral of PS2Controller is
type PS2_STATE is (IDLE, RECEIVING_DATA, WAIT_FOR_END_BIT, DATA_GOT, ERR);
signal state, next_state : PS2_STATE;
signal sr_data, sr_data_next : STD_LOGIC_VECTOR(7 downto 0);
signal sr_clk, sr_clk_next : STD_LOGIC_VECTOR(3 downto 0);
signal r_scancode, r_scancode_next : STD_LOGIC_VECTOR(7 downto 0);
signal r_parity, r_parity_next : STD_LOGIC;
signal bit_counter, bit_counter_next : UNSIGNED(3 downto 0);
signal r_error, r_error_next : STD_LOGIC;
begin

scancode <= r_scancode;
transmiting <= '0' when state = IDLE or state = DATA_GOT or state = ERR else '1';
data_received <= '1' when state = DATA_GOT else '0';
error <= r_error;

sr_data_next	<=	ps2_data & sr_data(7 downto 1) when state = RECEIVING_DATA and bit_counter >= 1 and bit_counter < 9 and sr_clk = "1100" else
						sr_data;
sr_clk_next	<=	sr_clk(2 downto 0) & ps2_clk;
r_scancode_next <=	sr_data when state = WAIT_FOR_END_BIT and sr_clk = "0011" and r_error = '0' else
							r_scancode;
r_parity_next	<=	'0' when state = WAIT_FOR_END_BIT else
						r_parity xor ps2_data when state = RECEIVING_DATA and bit_counter >= 1 and bit_counter < 9 and sr_clk = "1100" else 
						r_parity;
bit_counter_next <=	bit_counter + 1 when (state = IDLE or state = RECEIVING_DATA) and sr_clk = "1100" else
							(others => '0') when state = WAIT_FOR_END_BIT else
							bit_counter;
r_error_next <= not(r_parity xor ps2_data) when state = RECEIVING_DATA and bit_counter = 9 and sr_clk = "1100" else
					 r_error;
process (clk, state, reset)
begin
	if reset = '1' then
		state <= IDLE;
		sr_data <= (others => '0');
		sr_clk <= (others => '1');
		r_scancode <= (others => '0');
		r_parity <= '0';
		bit_counter <= (others => '0');
		r_error <= '0';
	elsif rising_edge(clk) then
		state <= next_state;
		sr_data <= sr_data_next;
		sr_clk <= sr_clk_next;
		r_scancode <= r_scancode_next;
		r_parity <= r_parity_next;
		bit_counter <= bit_counter_next;
		r_error <= r_error_next;
	end if;
end process;

process (state, sr_clk, bit_counter, r_error)
begin
	case state is
		when IDLE
					=> if sr_clk = "1100" then
							next_state <= RECEIVING_DATA;
						else
							next_state <= IDLE;
						end if;
		when RECEIVING_DATA
					=>	if sr_clk = "1100" then
							if bit_counter >= 1 and bit_counter < 10 then
								next_state <= RECEIVING_DATA;
							else
								next_state <= WAIT_FOR_END_BIT;
							end if;
						else
							next_state <= RECEIVING_DATA;
						end if;
		when WAIT_FOR_END_BIT
					=> if sr_clk = "0011" then
							if r_error = '0' then
								next_state <= DATA_GOT;
							else
								next_state <= ERR;
							end if;
						else
							next_state <= WAIT_FOR_END_BIT;
						end if;
		when DATA_GOT
					=> next_state <= IDLE;
		when ERR
					=> next_state <= IDLE;
	end case;
end process;
end Behavioral;

