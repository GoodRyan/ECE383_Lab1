----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:45 01/29/2014 
-- Design Name: 
-- Module Name:    h_sync_gen - Behavioral 
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
use IEEE.NUMERIC_STD.all;
library UNISIM;
use UNISIM.VComponents.all;

entity h_sync_gen is
	port( clk		: in std_logic;
			reset		: in std_logic;
			h_sync	: out std_logic;
			blank		: out std_logic;
			completed : out std_logic;
			column	: out unsigned (10 downto 0)
	);
end h_sync_gen;

architecture Behavioral of h_sync_gen is
	type state_type is
		(sync, back_porch, active_video, front_porch, completed_sig_gen);
	signal state_reg, state_next: state_type;
	signal counter_reg, counter_next: unsigned (10 downto 0);
	signal h_sync_next, blank_next, completed_next: std_logic;
	signal h_sync_reg, blank_reg, completed_reg: std_logic;
	signal column_next, column_reg: unsigned (10 downto 0);
begin
	--state register
	process(clk, reset)
	begin
		if (reset='1') then
			state_reg <= sync;
		elsif (clk'event and clk='1') then
			state_reg <= state_next;
		end if;
	end process;
	--next-state logic
	process(clk, reset)
	begin
		case state_reg is
			when sync =>
				if (counter_reg <= to_unsigned(96,11)) then
					state_next <= sync;
				else
					state_next <= back_porch;
				end if;
			when back_porch =>
				if (counter_reg <= 48) then
					state_next <= back_porch;
				else
					state_next <= completed_sig_gen;
				end if;
			when active_video =>
				if (counter_reg <= 640) then
					state_next <= active_video;
				else
					state_next <= front_porch;
				end if;
			when front_porch =>
				if (counter_reg <= 16) then
					state_next <= front_porch;
				else
					state_next <= sync;
				end if;
			when completed_sig_gen =>
				state_next <= active_video;
		end case;
	end process;


end Behavioral;

