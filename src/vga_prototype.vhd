library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity vga_sync is
	port (
			clk, reset: in std_logic;
			hsync, vsync : out std_logic;
			video_on: out std_logic;
			pixel_x , pixel_y : out UNSIGNED (9 downto 0)
		);
end vga_sync;
architecture arch of vga_sync is
--VGA 640 _ by _ 480 sync parameters
constant HD: integer := 640; --horizontal display area
constant HF : integer := 16; --h.front porch
constant HB : integer := 48; --h.back porch
constant HR : integer := 96; --h.retrace
constant VD : integer := 480; --vertical display area
constant VF : integer := 10; --v.front porch
constant VB : integer := 33; --v.back porch
constant VR : integer := 2; --v.retrace
--sync counters
signal v_count_reg : unsigned (9 downto 0);
signal h_count_reg : unsigned (9 downto 0);
--output buffer
signal v_sync_reg, h_sync_reg : std_logic;
signal v_sync_next, h_sync_next : std_logic;

begin
	--register
	process (clk , reset)
	begin
		if reset = '1' then
			v_count_reg <= (others => '0');
			h_count_reg <= (others => '0');
			v_sync_reg <= '0';
			h_sync_reg <= '0';
		elsif rising_edge(clk) then
			if h_count_reg = (HD+HF+HB+HR-1) then				
				h_count_reg <= (others => '0');
				if v_count_reg = (VD+VF+VB+VR-1) then
					v_count_reg <= (others => '0');
				else
					v_count_reg <= v_count_reg + 1;
				end if;
			else
				h_count_reg <= h_count_reg + 1;
			end if;
			v_sync_reg <= v_sync_next;
			h_sync_reg <= h_sync_next;
		end if;
	end process;
	-- horizontal and vertical sync, buffered to avoid glitch
	h_sync_next <=
		'1' when (h_count_reg>=(HD+HF))					--656
			  and (h_count_reg<=(HD+HF+HR-1)) else		--751
		'0';
	v_sync_next <=
		'1' when (v_count_reg>=(VD+VF))					--490
			  and (v_count_reg<=(VD+VF+VR-1)) else		--491
		'0';
	-- video on/off
	video_on <=
		'1' when (h_count_reg<HD) and (v_count_reg<VD) else
		'0';
	-- output signal
	hsync <= h_sync_reg;
	vsync <= v_sync_reg;
	pixel_x <= h_count_reg;
	pixel_y <= v_count_reg;
end arch;