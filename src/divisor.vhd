library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.ALL;

entity divisor is
	generic
	(
		input		:	natural := 100000000;
		output	:	natural := 25000000
	);
   port
	(
		reset: in STD_LOGIC;
		clk_entrada: in STD_LOGIC; 
		clk_salida: out STD_LOGIC
	);
end divisor;

architecture divisor_arch of divisor is
	constant half_input : natural := input/2;
	constant bits : natural := natural(CEIL(LOG2(real(half_input / output))));
	constant limit : UNSIGNED(bits - 1 downto 0) := to_unsigned(half_input/output,bits);
	signal cuenta: UNSIGNED(bits - 1 downto 0);
	signal clk_aux: STD_LOGIC := '0';  
begin

contador: process(reset, clk_entrada)
	begin
		if reset='1' then
			cuenta <= (others => '0');
		elsif rising_edge(clk_entrada) then
			if input/output = 2 then
				clk_aux <= not clk_aux;
			else
				if cuenta = limit - 1 then
					clk_aux <= not clk_aux;
					cuenta <= (others => '0');
				else
					cuenta <= cuenta + 1;
				end if;
			end if;
		end if;
	end process;
	
--OUTPUT
	clk_salida<=clk_aux;
end divisor_arch;
