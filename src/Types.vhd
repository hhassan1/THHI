library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Types is
	type PLAYER_SPRITES is (STILL,MOVEMENT_1_RIGHT,MOVEMENT_2_RIGHT,MOVEMENT_1_LEFT,MOVEMENT_2_LEFT,ATTACK);
	type PLAYER_PALETTE is (BLACK, RED, DARK_RED, SKIN, GREY, DARK_GREY, WHITE, ALPHA);
	type BALL_PALETTE is (BLACK, DARK_GREY, WHITE, ALPHA);
	type CARDS_PALETTE is (BLACK, RED, WHITE, ALPHA);
	constant BLACK_2 : std_logic_vector(1 downto 0) := "00";
	constant GREY_2 : std_logic_vector(1 downto 0) := "01";
	constant WHITE_2 : std_logic_vector(1 downto 0) := "10";
	constant ALPHA_2 : std_logic_vector(1 downto 0) := "11";
	constant BLACK_3 : std_logic_vector(2 downto 0) := "000";
	constant RED_3 : std_logic_vector(2 downto 0) := "001"; 
	constant DARK_RED_3 : std_logic_vector(2 downto 0) := "010";
	constant SKIN_3 : std_logic_vector(2 downto 0) := "011";
	constant GREY_3 : std_logic_vector(2 downto 0) := "100";
	constant DARK_GREY_3 : std_logic_vector(2 downto 0) := "101";
	constant WHITE_3 : std_logic_vector(2 downto 0) := "110";
	constant ALPHA_3 : std_logic_vector(2 downto 0) := "111";
	constant BLACK_9		: std_logic_vector(8 downto 0) := "000000000";
	constant RED_9			: std_logic_vector(8 downto 0) := "111000000";
	constant DARK_RED_9	: std_logic_vector(8 downto 0) := "100000000";
	constant SKIN_9		: std_logic_vector(8 downto 0) := "110101100";
	constant GREY_9		: std_logic_vector(8 downto 0) := "101100110";
	constant DARK_GREY_9	: std_logic_vector(8 downto 0) := "010010010";
	constant WHITE_9		: std_logic_vector(8 downto 0) := "111111111";
	constant quieto_width : integer := 21;
	constant mov1_width : integer := 30;
	constant mov2_width : integer := 27;
	constant quieto_height : integer := 32;
	constant mov1_height : integer := 32;
	constant mov2_height : integer := 32;
	constant p_height : natural := 25;
	constant p_width : natural := 25;
   constant clk_freq : natural := 50000000;
	constant pared_izq : integer := 0;
	constant pared_der : integer := 639;
end Types;

package body Types is
end Types;
