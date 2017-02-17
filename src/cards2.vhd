----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:35:44 11/25/2014 
-- Design Name: 
-- Module Name:    Cartas - Behavioral 
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

entity cards is
	port
	(
		clk 		    :	in STD_LOGIC;
		reset 			:	in STD_LOGIC;
		load_cards		:	in STD_LOGIC;
		level           :   in UNSIGNED(2 downto 0);
		ball_x			:	in UNSIGNED(9 downto 0);
		ball_y			:	in UNSIGNED(8 downto 0);
		vga_x			:	in UNSIGNED(9 downto 0);
		vga_y			:	in UNSIGNED(9 downto 0);
		no_cards_left	:	out STD_LOGIC;
		loaded			:	out STD_LOGIC;
		draw_sprite		:	out STD_LOGIC;
		card_out			:	out STD_LOGIC;
		rgb 				:	out STD_LOGIC_VECTOR(8 downto 0)
	);
end cards;

architecture Behavioral of cards is
component RAM is
	port
	(
		clk : in STD_LOGIC;
		addr : in STD_LOGIC_VECTOR(7 downto 0);
		din : in UNSIGNED(4 downto 0);
		we : in STD_LOGIC;
		dout : out UNSIGNED(4 downto 0)
	);
end component;
component cards_sprite_1 is port (sprite_num	:	in		UNSIGNED(2 downto 0); x				:	in		STD_LOGIC_VECTOR(9 downto 0); draw_sprite	:	out	STD_LOGIC; rgb			:	out	STD_LOGIC_VECTOR(8 downto 0) ); end component;
component cards_sprite_2 is port (sprite_num	:	in		UNSIGNED(2 downto 0); x				:	in		STD_LOGIC_VECTOR(9 downto 0); draw_sprite	:	out	STD_LOGIC; rgb			:	out	STD_LOGIC_VECTOR(8 downto 0) ); end component;
component cards_sprite_3 is port (sprite_num	:	in		UNSIGNED(2 downto 0); x				:	in		STD_LOGIC_VECTOR(9 downto 0); draw_sprite	:	out	STD_LOGIC; rgb			:	out	STD_LOGIC_VECTOR(8 downto 0) ); end component;
component random_bit_gen is port (clk	:	in	STD_LOGIC; rng:	out STD_LOGIC); end component;
type STATES is ( SET_RAM, WAIT_FOR_SCREEN_END,CHECK_CARDS,MOD_CARD,WAIT_FOR_UPDATE);
signal state, state_next : STATES;
signal mod_counter : UNSIGNED(7 downto 0);
signal vga_addr_counter : UNSIGNED(7 downto 0);
signal card_counter : UNSIGNED(7 downto 0);
signal addr : UNSIGNED(7 downto 0);
signal sprite_num : UNSIGNED(2 downto 0);
signal sprite_addr : STD_LOGIC_VECTOR(9 downto 0);
signal draw_sprite_1, draw_sprite_2, draw_sprite_3, wB_en, collision, screen_end : STD_LOGIC;
signal rgb_1, rgb_2, rgb_3 : STD_LOGIC_VECTOR(8 downto 0);
signal dB_in, dB_out : UNSIGNED(4 downto 0);
signal rng : STD_LOGIC;
signal pos_ball_card_array : UNSIGNED(8 downto 0);
begin

sprite_1: cards_sprite_1 port map (sprite_num, sprite_addr, draw_sprite_1, rgb_1);
sprite_2: cards_sprite_2 port map (sprite_num, sprite_addr, draw_sprite_2, rgb_2);
sprite_3: cards_sprite_3 port map (sprite_num, sprite_addr, draw_sprite_3, rgb_3);
ram_1: RAM port map (clk,std_logic_vector(addr),dB_in,wB_en,dB_out);
rand: random_bit_gen port map (clk, rng);
screen_end <= '1' when vga_x = 640 and vga_y = 479 else '0';
sprite_addr <= std_logic_vector(vga_y(4 downto 0)) & std_logic_vector(vga_x(4 downto 0));

draw_sprite <= draw_sprite_1 when level = 1 and vga_y(8 downto 7) /= "11" else
					draw_sprite_2 when level = 2 and vga_y(8 downto 7) /= "11" else
					draw_sprite_3 when level = 3 and vga_y(8 downto 7) /= "11" else
					'0';
rgb <=	rgb_1 when level = 1 else
			rgb_2 when level = 2 else
			rgb_3;
dB_in <= dB_out - 1 when state = MOD_CARD and ((dB_out /= 31) or (collision = '1')) and dB_out /= 0 else
			to_unsigned(31,dB_in'length) when state = SET_RAM and rng = '1' else
			to_unsigned(0,dB_in'length) when state = SET_RAM and rng = '0' else
			dB_out;
wB_en <= '1' when state = SET_RAM or state = MOD_CARD else '0';
addr <= vga_addr_counter when state = WAIT_FOR_SCREEN_END else
			mod_counter when state = SET_RAM or state = CHECK_CARDS or state = MOD_CARD else
			(others => '0');
sprite_num <= to_unsigned(0,sprite_num'length) when dB_out = 0 else
				  unsigned('0'& dB_out(4 downto 3)) + 1;
card_out <= '1' when state = MOD_CARD and dB_out = 1 else '0';
loaded <= '0' when state = SET_RAM else '1';
pos_ball_card_array <= ball_x(9 downto 5) + unsigned('0'&std_logic_vector(ball_y(8 downto 5))&"0000") + unsigned("000"&std_logic_vector(ball_y(8 downto 5))&"00");
collision <= '1' when pos_ball_card_array = mod_counter and pos_ball_card_array < 240 and ball_x(4) = '0' and ball_y(4) = '0' else 
				 '1' when pos_ball_card_array + 1 = mod_counter and pos_ball_card_array < 240 and ball_x(4) = '1' and ball_y(4) = '0' and ball_x < 615 else
				 '1' when pos_ball_card_array + 20 = mod_counter and pos_ball_card_array < 240 and ball_x(4) = '0' and ball_y(4) = '1' and ball_y < 359 else
				 '1' when pos_ball_card_array + 21 = mod_counter and pos_ball_card_array < 240 and ball_x(4) = '1' and ball_y(4) = '1' and ball_x < 615 and ball_y < 359 else
				 '0';
no_cards_left <= '1' when state = WAIT_FOR_UPDATE else '0';
process(clk,reset)
begin
	if reset = '1' then
	   state <= SET_RAM;
		card_counter <= (others => '0');
		mod_counter <= to_unsigned(40,mod_counter'length);
		vga_addr_counter <= (others => '0');
	elsif rising_edge(clk) then
	   state <= state_next;
		if state = MOD_CARD and dB_out = 1 then
			card_counter <= card_counter - 1;
		elsif state = SET_RAM and rng = '1' then
			card_counter <= card_counter + 1;
		end if;
		if state = WAIT_FOR_SCREEN_END or state = WAIT_FOR_UPDATE then
			mod_counter <= to_unsigned(40,mod_counter'length);
		elsif state = SET_RAM or state = MOD_CARD then
			mod_counter <= mod_counter + 1;
		end if;
		if vga_x = 798 and vga_y = 524 then
			vga_addr_counter <= (others => '0');
		elsif vga_x = 798 and vga_y(4 downto 0) = 31 then
			vga_addr_counter <= vga_addr_counter;
		elsif vga_x = 798 then
			vga_addr_counter <= vga_addr_counter - 20;
		elsif vga_x(4 downto 0) = 30 and vga_x(9 downto 7) < 5 then
			vga_addr_counter <= vga_addr_counter + 1;
		end if;
	end if;
end process;
process (state,mod_counter,screen_end,card_counter,load_cards)
begin
	case state is
		when SET_RAM
			=> if mod_counter = 239 then
					state_next <= WAIT_FOR_SCREEN_END;
				else
					state_next <= SET_RAM;
				end if;
		when WAIT_FOR_SCREEN_END
			=> if screen_end = '1' then
					state_next <= CHECK_CARDS;
				else
					state_next <= WAIT_FOR_SCREEN_END;
				end if;
		when CHECK_CARDS
			=> if mod_counter = 240 and card_counter = 0 then
					state_next <= WAIT_FOR_UPDATE;
				elsif mod_counter = 240 then
					state_next <= WAIT_FOR_SCREEN_END;
				else
					state_next <= MOD_CARD;
				end if;
		when MOD_CARD
			=> state_next <= CHECK_CARDS;
		when WAIT_FOR_UPDATE
			=> if load_cards = '1' then
					state_next <= SET_RAM;
				else
					state_next <= WAIT_FOR_UPDATE;
				end if;
		end case;
end process;
end Behavioral;


