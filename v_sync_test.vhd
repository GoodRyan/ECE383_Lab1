--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:01:11 01/31/2014
-- Design Name:   
-- Module Name:   C:/Users/C15Ryan.Good/Documents/classes/ECE/Lab1_VGA/v_sync_test.vhd
-- Project Name:  Lab1_VGA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: v_sync_gen
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
use ieee.numeric_std.ALL;
 
ENTITY v_sync_test IS
END v_sync_test;
 
ARCHITECTURE behavior OF v_sync_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT v_sync_gen
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         h_blank : IN  std_logic;
         h_completed : IN  std_logic;
         v_sync : OUT  std_logic;
         blank : OUT  std_logic;
         completed : OUT  std_logic;
         row : OUT  unsigned(10 downto 0);
         counter : OUT  unsigned(10 downto 0)
        );
    END COMPONENT;
	 
	 component h_sync_gen
	 port( clk			: in std_logic;
			reset			: in std_logic;
			h_sync		: out std_logic;
			blank			: out std_logic;
			completed	: out std_logic;
			column		: out unsigned (10 downto 0)
	);
end component;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal h_blank : std_logic := '0';
   signal h_completed : std_logic := '0';

 	--Outputs
   signal v_sync : std_logic;
   signal blank : std_logic;
   signal completed : std_logic;
   signal row : unsigned(10 downto 0);
   signal counter : unsigned(10 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: v_sync_gen PORT MAP (
          clk => clk,
          reset => reset,
          h_blank => h_blank,
          h_completed => h_completed,
          v_sync => v_sync,
          blank => blank,
          completed => completed,
          row => row,
          counter => counter
        );
	
	h_sync_comp: h_sync_gen PORT MAP (
			clk => clk,
			reset => reset,
			h_sync => open,
			blank => open,
			completed => h_completed,
			column => open
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
      -- hold reset state for 100 ns.
      wait for clk_period;	


      -- insert stimulus here 

      wait;
   end process;

END;
