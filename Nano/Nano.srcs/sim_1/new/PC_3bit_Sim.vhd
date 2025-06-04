----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 04:01:13 PM
-- Design Name: 
-- Module Name: PC_3bit_Sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_PC_3bit is
end TB_PC_3bit;

architecture Behavioral of TB_PC_3bit is
    -- Component Declaration for the Unit Under Test (UUT)
    component PC_3bit
        Port (
            Reset         : in STD_LOGIC;
            Clk           : in STD_LOGIC;
            MemorySelect  : out STD_LOGIC_VECTOR (2 downto 0);
            JumpAddr      : in STD_LOGIC_VECTOR (2 downto 0);
            JumpFlag      : in STD_LOGIC
        ); 
    end component;

    -- Inputs
    signal Reset : STD_LOGIC := '0';
    signal Clk : STD_LOGIC := '0';
    signal JumpAddr : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal JumpFlag : STD_LOGIC := '0';
    
    -- Outputs
    signal MemorySelect : STD_LOGIC_VECTOR(2 downto 0);
    
    -- Clock period definitions
    constant Clk_period : time := 100 ns;
    
    
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: PC_3bit port map (
        Reset => Reset,
        Clk => Clk,
        MemorySelect => MemorySelect,
        JumpAddr => JumpAddr,
        JumpFlag => JumpFlag
    );

    -- Clock process definitions
    Clk_process: process
    begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
        begin
            -- Phase 1: Initial Reset
            Reset <= '1';
            wait for Clk_period*2;
            Reset <= '0';
            
            -- Phase 2: Count normally for 3 cycles (expect 001, 010, 011)
            wait for Clk_period*3;
            
            -- Phase 3: Jump to 5 ("101")
            JumpAddr <= "111";
            JumpFlag <= '1';
            wait for Clk_period;
            JumpFlag <= '0';
            
            -- Phase 4: Count normally for 1 cycle (expect 110)
            wait for Clk_period*3;
            
            -- End simulation
            wait;
        end process;
end Behavioral;