--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:39:20 11/19/2014
-- Design Name:   
-- Module Name:   J:/JuegoSimple/Test.vhd
-- Project Name:  JuegoSimple
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Chip
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test IS
END Test;
 
ARCHITECTURE behavior OF Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Chip
    Port ( clk_100 : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ps2_clk : in STD_LOGIC;
			  ps2_data : in STD_LOGIC;
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC;
           rgb : out  STD_LOGIC_VECTOR (8 downto 0);
			  tec : out STD_LOGIC_VECTOR(6 downto 0);
			  transmiting : out STD_LOGIC;
			  data_re : out STD_LOGIC;
			  error : out STD_LOGIC;
			  pwm : out std_logic
			 );
    END COMPONENT;
    

   --Inputs
	signal ps2_clk : std_logic := '1';
   signal ps2_data : std_logic := '1';
   signal clk_50 : std_logic := '1';
   signal rst : std_logic := '0';

	--BiDirs
   signal hsync : std_logic;

 	--Outputs
   signal vsync : std_logic;
   signal rgb : std_logic_vector(8 downto 0);
   signal tec : STD_LOGIC_VECTOR(6 downto 0);
		signal 	  transmiting : STD_LOGIC;
		signal 	  data_re : STD_LOGIC;
		signal 	  error : STD_LOGIC;
		signal pwm : std_logic;

   -- Clock period definitions
   constant clk_100_period : time := 20 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Chip PORT MAP (
          clk_100 => clk_50,
          rst => rst,
          ps2_clk => ps2_clk,
			  ps2_data => ps2_data,
          hsync => hsync,
          vsync => vsync,
          rgb => rgb,
          tec => tec,
			 transmiting => transmiting,
			 data_re => data_re,
			 error => error,
			 pwm => pwm
        );

   -- Clock process definitions
   clk_100_process :process
   begin
		clk_50 <= '0';
		wait for clk_100_period/2;
		clk_50 <= '1';
		wait for clk_100_period/2;
   end process; 

   -- Stimulus process
   stim_proc: process 
   begin		
      rst <= '0';
      wait for 100 ns;	
		rst <= '1';
      wait for 10 ms;
      -- insert stimulus here 
      wait;
   end process;
--	process (clk_100)
--    file file_pointer: text is out "write.txt";
--    variable line_el: line;
--	begin
--		if rising_edge(clk_100) then
--        -- Write the time
--        write(line_el, now); -- write the line.
--        write(line_el, ":"); -- write the line.
--        -- Write the hsync
--        write(line_el, " ");
--        write(line_el, hsyncb); -- write the line.
--        -- Write the vsync
--        write(line_el, " ");
--        write(line_el, vsyncb); -- write the line.
--        -- Write the red
--        write(line_el, " ");
--        write(line_el, rgb(8 downto 6)); -- write the line.
--        -- Write the green
--        write(line_el, " ");
--        write(line_el, rgb(5 downto 3)); -- write the line.
--        -- Write the blue
--        write(line_el, " ");
--        write(line_el, rgb(2 downto 0)); -- write the line.
--        writeline(file_pointer, line_el); -- write the contents into the file.
--		end if;
--	end process;	
END;
