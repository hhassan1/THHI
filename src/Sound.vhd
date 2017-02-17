----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:45 01/02/2015 
-- Design Name: 
-- Module Name:    Sound - Behavioral 
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

entity Sound is
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		ampPWM : out std_logic;
		ampSD : out std_logic
	);
end Sound;

architecture Behavioral of Sound is
component PFM is
	 Generic ( n : natural := 1);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           limit : in  UNSIGNED(n - 1 downto 0);
           clk_out : out  STD_LOGIC);
end component;
component bass_1_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(3 downto 0);
			d_out: out UNSIGNED(17 downto 0));
end component;
component bass_2_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(3 downto 0);
			d_out: out UNSIGNED(17 downto 0));
end component;
component bass_3_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(3 downto 0);
			d_out: out UNSIGNED(15 downto 0));
end component;
component bass_4_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(3 downto 0);
			d_out: out UNSIGNED(16 downto 0));
end component;
component vibra_1_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(3 downto 0);
			d_out: out UNSIGNED(15 downto 0));
end component;
component vibra_2_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(5 downto 0);
			d_out: out UNSIGNED(14 downto 0));
end component;
component lead_1_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(4 downto 0);
			d_out: out UNSIGNED(15 downto 0));
end component;
component lead_2_rom is
	port( clk : in STD_LOGIC;
			en : in STD_LOGIC;
			addr:	in UNSIGNED(4 downto 0);
			d_out: out UNSIGNED(15 downto 0));
end component;

signal pace_director : unsigned(6 downto 0);
signal pace_director_2 : unsigned(8 downto 0);
signal clk_bass_1_limit, clk_bass_2_limit: unsigned(17 downto 0);
signal clk_vibra_limit,clk_lead_1_limit,clk_lead_2_limit : unsigned(15 downto 0);
signal clk_vibra_2_limit : unsigned(14 downto 0);
signal clk_bass_3_limit : unsigned(15 downto 0);
signal clk_bass_4_limit : unsigned(16 downto 0);
signal clk_pace_1, clk_pace_2, clk_pace_3: std_logic;
signal channel_1,channel_2,channel_3,channel_4,channel_5 : std_logic;
signal note_bass_addr, note_vibra_addr : unsigned(3 downto 0);
signal note_lead_addr : unsigned(4 downto 0);
signal note_bass_3_addr : unsigned (3 downto 0);
signal note_vibra_2_addr : unsigned (5 downto 0);
signal clk_switch_counter : unsigned(12 downto 0);
signal ch_1_limit : unsigned(17 downto 0);
signal ch_2_limit : unsigned(17 downto 0);
signal ch_3_limit : unsigned(15 downto 0);
signal ch_4_limit : unsigned(15 downto 0);
signal ch_5_limit : unsigned(15 downto 0);
signal pace_1 : unsigned(25 downto 0);
signal pace_2 : unsigned(23 downto 0);
signal pace_3 : unsigned(23 downto 0);
begin
ch_1_limit <=	clk_bass_1_limit when (pace_director <= 48 or pace_director > 64) else
					resize(clk_bass_3_limit,18);
ch_2_limit <= 	clk_bass_2_limit when (pace_director <= 48 or pace_director > 64) else
					resize(clk_bass_4_limit,18);
ch_3_limit <= 	clk_vibra_limit when (pace_director <= 48 and pace_director > 14) else
					resize(clk_vibra_2_limit,16) when (pace_director_2 <= 382 and pace_director_2 > 254) else
					(others => '0');
ch_4_limit <=	clk_lead_1_limit;
ch_5_limit <=	clk_lead_2_limit;
process(clk,reset)
begin
	if reset = '1' then
		pace_1 <= (others => '0');
		pace_2 <= (others => '0');
		pace_3 <= (others => '0');
	elsif rising_edge(clk) then
		if pace_1 = 39999999 then
			pace_1 <= (others => '0');
		else
			pace_1 <= pace_1 + 1;
		end if;
		if pace_2 = 9999999 then
			pace_2 <= (others => '0');
		else
			pace_2 <= pace_2 + 1;
		end if;
		if pace_3 = 4999999 then
			pace_3 <= (others => '0');
		else
			pace_3 <= pace_3 + 1;
		end if;
	end if;
end process;
clk_pace_1 <= '1' when pace_1 = 19999999 else '0';
clk_pace_2 <= '1' when pace_2 = 4999999 else '0';
clk_pace_3 <= '1' when pace_3 = 2499999 else '0';
ch_1 : PFM generic map (ch_1_limit'length) port map ( clk, reset, ch_1_limit, channel_1);
ch_2 : PFM generic map (ch_2_limit'length) port map ( clk, reset, ch_2_limit, channel_2);
ch_3 : PFM generic map (ch_3_limit'length) port map ( clk, reset, ch_3_limit, channel_3);
ch_4 : PFM generic map (ch_4_limit'length) port map ( clk, reset, ch_4_limit, channel_4);
ch_5 : PFM generic map (ch_5_limit'length) port map ( clk, reset, ch_5_limit, channel_5);
b_1_rom : bass_1_rom port map (clk, clk_pace_1, note_bass_addr, clk_bass_1_limit);
b_2_rom : bass_2_rom port map (clk, clk_pace_1, note_bass_addr, clk_bass_2_limit);
b_3_rom : bass_3_rom port map (clk, clk_pace_1, note_bass_3_addr, clk_bass_3_limit);
b_4_rom : bass_4_rom port map (clk, clk_pace_1, note_bass_3_addr, clk_bass_4_limit);
v_1_rom : vibra_1_rom port map (clk, clk_pace_1, note_vibra_addr, clk_vibra_limit);
v_2_rom : vibra_2_rom port map (clk, clk_pace_2, note_vibra_2_addr, clk_vibra_2_limit);
l_1_rom : lead_1_rom port map (clk, clk_pace_3, note_lead_addr, clk_lead_1_limit);
l_2_rom : lead_2_rom port map (clk, clk_pace_3, note_lead_addr, clk_lead_2_limit);
process(clk, reset)
begin
	if reset = '1' then
		clk_switch_counter <= (others => '0');
	elsif rising_edge(clk) then
		clk_switch_counter <= clk_switch_counter + 1;
	end if;
end process;
process(clk, reset)
begin
	if reset = '1' then
		note_bass_addr <= (others => '0');
	elsif rising_edge(clk) then
		if clk_pace_1 = '1' then
			if pace_director < 48 or pace_director >= 64 then
				note_bass_addr <= note_bass_addr + 1;
			else
				note_bass_addr <= (others => '0');
			end if;
		end if;
	end if;
end process;
process(clk, reset)
begin
	if reset = '1' then
		note_bass_3_addr <= (others => '0');
	elsif rising_edge(clk) then
		if clk_pace_1 = '1' then
			if pace_director < 64 and pace_director >= 48 then
				note_bass_3_addr <= note_bass_3_addr + 1;
			else
				note_bass_3_addr <= (others => '0');
			end if;
		end if;
	end if;
end process;
process(clk, reset)
begin
	if reset = '1' then
		pace_director <= (others => '0');
	elsif rising_edge(clk) then
		if clk_pace_1 = '1' then
			if pace_director = 95 then
				pace_director <= (others => '0');
			else
				pace_director <= pace_director + 1;
			end if;
		end if;
	end if;
end process;	
process(clk, reset)
begin
	if reset = '1' then
		note_vibra_addr <= (others => '0');
	elsif rising_edge(clk) then
		if clk_pace_1 = '1' then
			if pace_director < 48 and pace_director >= 14 then
				if pace_director = 19 or pace_director = 23 or pace_director = 35 or pace_director = 39 then
					note_vibra_addr <= "0010";
				elsif pace_director = 29 then
					note_vibra_addr <= "0000";
				else
					note_vibra_addr <= note_vibra_addr + 1;
				end if;
			else
				note_vibra_addr <= (others => '0');
			end if;
		end if;
	end if;
end process;
process(clk, reset)
begin
	if reset = '1' then
		pace_director_2 <= (others => '0');
	elsif rising_edge(clk) then
		if clk_pace_2 = '1' then
			if pace_director_2 = 383 then
				pace_director_2 <= (others => '0');
			else
				pace_director_2 <= pace_director_2 + 1;
			end if;
		end if;
	end if;
end process;
process(clk, reset)
begin
	if reset = '1' then
		note_vibra_2_addr <= (others => '0');
	elsif rising_edge(clk) then
		if clk_pace_2 = '1' then
			if pace_director_2 < 382 and pace_director_2 >= 254 then
				note_vibra_2_addr <= note_vibra_2_addr + 1;
			else
				note_vibra_2_addr <= (others => '0');
			end if;
		end if;
	end if;
end process;

process(clk, reset)
begin
	if reset = '1' then
		note_lead_addr <= (others => '0');
	elsif rising_edge(clk) then
		if clk_pace_3 = '1' then
			note_lead_addr <= note_lead_addr + 1;
		end if;
	end if;
end process;
ampPWM <=	channel_1 when clk_switch_counter(12 downto 10) = "000" or clk_switch_counter(12 downto 10) = "100" else
				channel_2 when clk_switch_counter(12 downto 10) = "001" or clk_switch_counter(12 downto 10) = "101" else
				channel_3 when clk_switch_counter(12 downto 10) = "010" or clk_switch_counter(12 downto 10) = "110" else
				channel_4 when clk_switch_counter(12 downto 9) = "0111" else
				channel_5 when clk_switch_counter(12 downto 9) = "1111" else
				'0';
ampSD <= '1';
end Behavioral;

