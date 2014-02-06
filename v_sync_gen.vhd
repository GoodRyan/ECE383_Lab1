----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:16:08 01/30/2014 
-- Design Name: 
-- Module Name:    v_sync_gen - Behavioral 
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

entity v_sync_gen is
	generic(
			  sync_count: natural;
			  back_porch_count: natural;
			  active_video_count: natural;
			  front_porch_count: natural
	);
	port ( clk				: in std_logic;
			 reset			: in std_logic;
			 h_completed 	: in std_logic;
			 v_sync			: out std_logic;
			 blank			: out std_logic;
			 completed 		: out std_logic;
			 row				: out unsigned(10 downto 0)
	);
end v_sync_gen;

architecture v_sync_arch of v_sync_gen is

	type state_type is
		(sync, back_porch, active_video, front_porch, completed_sig_gen);
	signal state_reg, state_next: state_type;
	signal counter_reg, counter_next: unsigned (10 downto 0);
	signal v_sync_reg, blank_reg, completed_reg: std_logic;
	signal v_sync_next, blank_next, completed_next: std_logic;
	signal row_next, row_reg: unsigned (10 downto 0);

begin
	
	--counter
	counter_next <= 	(others => '0') when state_next /= state_reg else
							counter_reg + 1 when h_completed = '1' else
							counter_reg;
	
	process(clk, reset)
	begin
		if reset = '1' then
			counter_reg <= (others => '0');
		elsif rising_edge(clk) then
			counter_reg <= counter_next;
		end if;
	end process;
	
	--state register
	process(clk, reset)
	begin
		if reset='1' then
			state_reg <= sync;
		elsif rising_edge(clk) then
			state_reg <= state_next;
		end if;
	end process;
	
	--output buffer
	process(clk)
	begin
		if rising_edge(clk) then
			v_sync_reg <= v_sync_next;
			blank_reg <= blank_next;
			row_reg <= row_next;
			completed_reg <= completed_next;
		end if;
	end process;
	
	--next-state logic
	process(state_next, counter_reg, h_completed)
	begin
		state_next <= state_reg;
		if h_completed = '1' then
			case state_reg is
				when sync =>
					if (counter_reg >= sync_count - 1) then
						state_next <= back_porch;
					end if;
				when back_porch =>
					if (counter_reg >= back_porch_count - 2) then
						state_next <= completed_sig_gen;
					end if;
				when active_video =>
					if (counter_reg >= active_video_count - 1) then
						state_next <= front_porch;
					end if;
				when front_porch =>
					if (counter_reg >= front_porch_count - 1) then
						state_next <= sync;
					end if;
				when completed_sig_gen =>
					state_next <= active_video;
			end case;
		end if;
	end process;
	
	--output logic
	process(state_next, counter_next)
	begin
		case state_next is
			when sync =>
				v_sync_next <= '0';
				blank_next <= '1';
				row_next <= (others => '0');
				completed_next <= '0';
			when back_porch =>
				v_sync_next <= '1';
				blank_next <= '1';
				row_next <= (others => '0');
				completed_next <= '0';
			when completed_sig_gen =>
				v_sync_next <= '1';
				blank_next <= '1';
				row_next <= (others => '0');
				completed_next <= '1';
			when active_video =>
				v_sync_next <= '1';
				blank_next <= '0';
				row_next <= counter_next;
				completed_next <= '0';
			when front_porch =>
				v_sync_next <= '1';
				blank_next <= '1';
				row_next <= (others => '0');
				completed_next <= '0';
		end case;
	end process;
	--output	
	v_sync <= v_sync_reg;
	blank <= blank_reg;
	row <= row_reg;
	completed <= completed_reg;
end v_sync_arch;

