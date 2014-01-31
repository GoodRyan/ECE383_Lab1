----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:00:26 01/30/2014 
-- Design Name: 
-- Module Name:    vga_sync - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_sync is
	port ( 
		clk			: in std_logic;
		reset			: in std_logic;
		h_sync		: out std_logic;
		v_sync		: out std_logic;
		v_completed : out std_logic;
		blank			: out std_logic;
		row			: out unsigned(10 downto 0);
		column		: out unsigned(10 downto 0);
		v_counter	: out unsigned(10 downto 0)
	);
end vga_sync;

architecture Behavioral of vga_sync is

component h_sync_gen
	port( clk			: in std_logic;
			reset			: in std_logic;
			h_sync		: out std_logic;
			blank			: out std_logic;
			completed	: out std_logic;
			column		: out unsigned (10 downto 0)
	);
end component;

component v_sync_gen
	port ( clk				: in std_logic;
			 reset			: in std_logic;
			 h_completed 	: in std_logic;
			 v_sync			: out std_logic;
			 blank			: out std_logic;
			 completed 		: out std_logic;
			 row				: out unsigned(10 downto 0);
			 counter			: out unsigned(10 downto 0)
	);
end component;

signal h_blank_sig, v_blank_sig, h_completed_sig: std_logic;

begin

h_sync_instance: h_sync_gen
	port map(
		clk => clk,
		reset => reset,
		h_sync => h_sync,
		blank => h_blank_sig,
		completed => h_completed_sig,
		column => column
	);

v_sync_instance: v_sync_gen
	port map(
		clk => clk,
		reset => reset,
		h_completed => h_completed_sig,
		v_sync => v_sync,
		blank => v_blank_sig,
		completed => v_completed,
		row => row,
		counter => v_counter
	);

blank <= '1' when (h_blank_sig ='1' and v_blank_sig = '1') else
			'0';

end Behavioral;

