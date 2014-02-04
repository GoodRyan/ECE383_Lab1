--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:49:40 01/30/2014
-- Design Name:   
-- Module Name:   C:/Users/C15Ryan.Good/Documents/classes/ECE/Lab1_VGA/h_sync_test.vhd
-- Project Name:  Lab1_VGA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: h_sync_gen
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
library UNISIM;
use UNISIM.VComponents.all;

ENTITY h_sync_test IS
END h_sync_test;
 
ARCHITECTURE behavior OF h_sync_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT h_sync_gen
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         h_sync : OUT  std_logic;
         blank : OUT  std_logic;
         completed : OUT  std_logic;
         column : OUT  unsigned(10 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal h_sync : std_logic;
   signal blank : std_logic;
   signal completed : std_logic;
   signal column : unsigned(10 downto 0);


   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: h_sync_gen PORT MAP (
          clk => clk,
          reset => reset,
          h_sync => h_sync,
          blank => blank,
          completed => completed,
          column => column

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
      wait for clk_period;	
		
		reset <= '1';
		wait for clk_period;
		
		reset <= '0';
		wait for clk_period;
		
		--Test Sync
		assert h_sync = '0' report "sync h_sync incorrect" severity error;
		assert blank = '1' report "sync blank incorrect" severity error;
		assert completed = '0' report "sync completed incorrect" severity error;
		assert column = "00000000000" report "sync column incorrect" severity error;
		
		--Test Back Porch
		wait for clk_period*96;
		assert h_sync = '1' report "Back porch h_sync incorrect" severity error;
		assert blank = '1' report "Back porch blank incorrect" severity error;
		assert completed = '0' report "Back porch completed incorrect" severity error;
		assert column = "00000000000" report "Back porch column incorrect" severity error;
		
		--Test completed
		wait for clk_period*48;
		assert h_sync = '1' report "Completed h_sync incorrect" severity error;
		assert blank = '1' report "Completed blank incorrect" severity error;
		assert completed = '1' report "Completed 'completed' incorrect" severity error;
		assert column = "00000000000" report "Completed column incorrect" severity error;

      --Test Active Video
		wait for clk_period*1;
		assert h_sync = '1' report "Active Vid h_sync incorrect" severity error;
		assert blank = '0' report "Active Vid blank incorrect" severity error;
		assert completed = '0' report "Active Vid completed incorrect" severity error;
		assert column = "00000000000" report "Active Vid column incorrect" severity error;
		
		wait for clk_period*11;
		assert column = "00000001010" report "Active Vid column(count 10) incorrect" 
		severity error;
		
		wait for clk_period*50;
		assert column = "00000111100" report "Active vid column(count 60) incorrect"
		severity error;
		
		--Test Front Porch
		wait for clk_period*581;
		assert h_sync = '1' report "Front Porch h_sync incorrect" severity error;
		assert blank = '1' report "Front Porch blank incorrect" severity error;
		assert completed = '0' report "Front Porch completed incorrect" severity error;
		assert column = "00000000000" report "Front Porch column incorrect" severity error;

      wait;
   end process;

END;
