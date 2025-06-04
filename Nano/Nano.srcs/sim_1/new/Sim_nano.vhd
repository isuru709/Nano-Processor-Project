----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025
-- Design Name: Nanoprocessor Testbench
-- Module Name: Nanoprocessor_tb - Behavioral
-- Project Name: Nano Processor Project
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for top-level Nanoprocessor module
-- 
-- Dependencies: Nanoprocessor.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Nanoprocessor is
--  No ports in testbench
end TB_Nanoprocessor;

architecture Behavioral of TB_Nanoprocessor is

    -- Component Under Test (CUT)
    component Nanoprocessor is
        Port (
            Reset : in STD_LOGIC;
            clk : in STD_LOGIC;
            Zero_LED : out STD_LOGIC;
            Overflow_LED : out STD_LOGIC;
            LED0 : out STD_LOGIC;
            LED1 : out STD_LOGIC;
            LED2 : out STD_LOGIC;
            LED3 : out STD_LOGIC;
            Anode : out STD_LOGIC_VECTOR (3 downto 0);
            S_7Seg : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    -- Signals to connect to the CUT
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal zero_led    : STD_LOGIC;
    signal overflow_led: STD_LOGIC;
    signal led0, led1, led2, led3 : STD_LOGIC;
    signal anode       : STD_LOGIC_VECTOR (3 downto 0);
    signal s_7seg      : STD_LOGIC_VECTOR (6 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Nanoprocessor
    uut: Nanoprocessor
    port map (
        Reset => reset,
        clk => clk,
        Zero_LED => zero_led,
        Overflow_LED => overflow_led,
        LED0 => led0,
        LED1 => led1,
        LED2 => led2,
        LED3 => led3,
        Anode => anode,
        S_7Seg => s_7seg
    );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
        
        if now >= 1000 ns then
            wait;
        end if;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Wait for a few clock cycles for instruction execution
        wait for 300 ns;

        -- Optional: trigger another reset or monitor output
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        wait for 200 ns;
        -- End simulation
        wait;
    end process;

end Behavioral;
