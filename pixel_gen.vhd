----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:18:56 01/31/2014 
-- Design Name: 
-- Module Name:    pixel_gen - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity pixel_gen is
	port  ( row      : in unsigned(10 downto 0);
           column   : in unsigned(10 downto 0);
           blank    : in std_logic;
			  switch_7 : in std_logic;
			  switch_6 : in std_logic;
           r        : out std_logic_vector(7 downto 0);
           g        : out std_logic_vector(7 downto 0);
           b        : out std_logic_vector(7 downto 0));
end pixel_gen;

architecture pixel_arch of pixel_gen is
begin

	process (row, column, blank)
	begin
		--initial states
		r <= (others => '0');
		g <= (others => '0');
		b <= (others => '0');
		
		if blank = '0' then
		
			--switch logic 1
			if (switch_7 <= '0') and (switch_6 <= '0') then
				if (row < 200 and column < 250) then
					r <= (others => '1');
					g <= (others => '0');
					b <= (others => '0');
				elsif (row < 300 and column >=250) then
					r <= (others => '0');
					g <= (others => '1');
					b <= (others => '0');
				elsif (row >= 300) then
					r <= (others => '0');
					g <= (others => '0');
					b <= (others => '1');
				end if;
			
			--switch logic 2
			elsif (switch_7 <= '0') and (switch_6 <= '1') then
				if (row < 200 and column < 250) then
					r <= (others => '0');
					g <= (others => '1');
					b <= (others => '0');
				elsif (row < 300 and column >=250) then
					r <= (others => '1');
					g <= (others => '0');
					b <= (others => '0');
				elsif (row >= 300) then
					r <= (others => '1');
					g <= (others => '1');
					b <= (others => '0');
				end if;
			
			--Switch logic 3
			elsif (switch_7 <= '1') and (switch_6 <= '0') then
				if (row < 200 and column < 250) then
					r <= (others => '1');
					g <= (others => '0');
					b <= (others => '1');
				elsif (row < 300 and column >=250) then
					r <= (others => '0');
					g <= (others => '0');
					b <= (others => '1');
				elsif (row >= 300) then
					r <= (others => '0');
					g <= (others => '1');
					b <= (others => '1');
				end if;
			
			--Switch logic 4
			elsif (switch_7 <= '1') and (switch_6 <= '1') then
				if (row < 200 and column < 250) then
					r <= (others => '0');
					g <= (others => '1');
					b <= (others => '1');
				elsif (row < 300 and column >=250) then
					r <= (others => '1');
					g <= (others => '1');
					b <= (others => '0');
				elsif (row >= 300) then
					r <= (others => '1');
					g <= (others => '0');
					b <= (others => '1');
				end if;
				
			end if;
			
		end if;
		
	end process;
	
end pixel_arch;