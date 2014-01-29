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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

begin


end Behavioral;

