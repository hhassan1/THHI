----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:40:10 11/04/2014 
-- Design Name: 
-- Module Name:    PS2Interface - Behavioral 
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

entity PS2Interface is
    Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  ps2_clk : in STD_LOGIC;
			  ps2_data : in STD_LOGIC;
           keyboard : out STD_LOGIC_VECTOR(6 downto 0);
			  transmiting : out STD_LOGIC;
           data_re : out STD_LOGIC;
           error : out STD_LOGIC);
end PS2Interface;

architecture Behavioral of PS2Interface is
component PS2Controller is
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
end component;
constant UNPRESS : STD_LOGIC_VECTOR(7 downto 0) := x"F0";
constant ESC_KEY : STD_LOGIC_VECTOR(7 downto 0) := x"76";
constant Z_KEY : STD_LOGIC_VECTOR(7 downto 0) := x"1A";
constant X_KEY : STD_LOGIC_VECTOR(7 downto 0) := x"22";
constant UP_KEY : STD_LOGIC_VECTOR(7 downto 0) := x"75";
constant DOWN_KEY : STD_LOGIC_VECTOR(7 downto 0) := x"72";
constant LEFT_KEY : STD_LOGIC_VECTOR(7 downto 0) := x"6B";
constant RIGHT_KEY : STD_LOGIC_VECTOR(7 downto 0) := x"74";
type PS2INT_STATE is (IDLE, DATA, KEY, BREAK, BREAKKEY);
signal state, next_state : PS2INT_STATE;
signal scancode : STD_LOGIC_VECTOR(7 downto 0);
signal data_received : STD_LOGIC;
signal r_esc, r_esc_next, r_z, r_z_next, r_x, r_x_next, r_up, r_up_next, r_down, r_down_next, r_left, r_left_next, r_right, r_right_next, r_break, r_break_next : STD_LOGIC;
begin

process (clk, reset)
begin
	if reset = '1' then
		state <= IDLE;
		r_esc <= '0';
		r_z <= '0';
		r_x <= '0';
		r_up <= '0';
		r_down <= '0';
		r_left <= '0';
		r_right <= '0';
		r_break <= '0';		
	elsif rising_edge(clk) then
		state <= next_state;
		r_esc <= r_esc_next;
		r_z <= r_z_next;
		r_x <= r_x_next;
		r_up <= r_up_next;
		r_down <= r_down_next;
		r_left <= r_left_next;
		r_right <= r_right_next;
		r_break <= r_break_next;
	end if;
end process;

process (state, data_received, scancode, r_break)
begin
	case state is
		when IDLE =>	if data_received = '1' then
								next_state <= DATA;
							else
								next_state <= IDLE;
							end if;
		when DATA =>	if scancode = UNPRESS then
								next_state <= BREAK;
							elsif r_break = '1' then
								next_state <= BREAKKEY;
							else
								next_state <= KEY;
							end if;
		when KEY|BREAK|BREAKKEY
					=>	next_state <= IDLE;
	end case;
end process;

ps2_ctrl : PS2Controller port map(	clk, reset,	ps2_clk, ps2_data, scancode, transmiting, data_received, error);
data_re <= data_received;


r_esc_next <=	'1' when state = KEY and scancode = ESC_KEY else
					'0' when state = BREAKKEY and scancode = ESC_KEY else
					r_esc;
r_z_next <=	'1' when state = KEY and scancode = Z_KEY else
				'0' when state = BREAKKEY and scancode = Z_KEY else
				r_z;
r_x_next <=	'1' when state = KEY and scancode = X_KEY else
				'0' when state = BREAKKEY and scancode = X_KEY else
				r_x;
r_up_next <=	'1' when state = KEY and scancode = UP_KEY else
					'0' when state = BREAKKEY and scancode = UP_KEY else
					r_up;
r_down_next <=	'1' when state = KEY and scancode = DOWN_KEY else
					'0' when state = BREAKKEY and scancode = DOWN_KEY else
					r_down;
r_left_next <=	'1' when state = KEY and scancode = LEFT_KEY else
					'0' when state = BREAKKEY and scancode = LEFT_KEY else
					r_left;
r_right_next <=	'1' when state = KEY and scancode = RIGHT_KEY else
						'0' when state = BREAKKEY and scancode = RIGHT_KEY else
						r_right;
r_break_next <=	'1' when state = BREAK else
						'0' when state = BREAKKEY else
						r_break;				
keyboard <= r_esc & r_z & r_x & r_up & r_down & r_left & r_right;


end Behavioral;