library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Slow_Clk is
-- Testbench has no ports
end TB_Slow_Clk;

architecture Behavioral of TB_Slow_Clk is

    -- Component declaration of the Unit Under Test (UUT)
    component Slow_Clk
        Port (
            Clk_in : in STD_LOGIC;
            Clk_out : out STD_LOGIC
        );
    end component;

    -- Testbench signals
    signal Clk_in_tb : STD_LOGIC := '0';
    signal Clk_out_tb : STD_LOGIC;

    constant clk_period : time := 10 ns; -- Simulated clock period

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Slow_Clk
        Port map (
            Clk_in => Clk_in_tb,
            Clk_out => Clk_out_tb
        );

    -- Clock generation process
    clk_process : process
    begin
        while now < 500 ns loop  -- run for limited simulation time
            Clk_in_tb <= '0';
            wait for clk_period / 2;
            Clk_in_tb <= '1';
            wait for clk_period / 2;
        end loop;
        wait; -- stop simulation
    end process;

end Behavioral;
