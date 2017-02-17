--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:18:27 02/17/2015
-- Design Name:   
-- Module Name:   J:/V3_2/BCDTest.vhd
-- Project Name:  V2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BCD
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY BCDTest IS
END BCDTest;
 
ARCHITECTURE behavior OF BCDTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BCD
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         binary : IN  UNSIGNED(23 downto 0);
         finish : OUT  std_logic;
         output : OUT  UNSIGNED(27 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal binary : UNSIGNED(23 downto 0) := to_unsigned(500,24);

 	--Outputs
   signal finish : std_logic;
   signal output : UNSIGNED(27 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BCD PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          binary => binary,
          finish => finish,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*10;
		start <= '1';
		wait for 50 ns;
		start <= '0';
		wait;
   end process;

END;
