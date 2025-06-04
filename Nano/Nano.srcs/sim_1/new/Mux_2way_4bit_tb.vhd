----------------------------------------------------------------------------------
-- Testbench for Mux_2way_4bit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Mux_2way_4bit is
-- no ports for testbench
end TB_Mux_2way_4bit;

architecture Behavioral of TB_Mux_2way_4bit is

    -- Component declaration
    component Mux_2way_4bit
        Port ( AddSub : in STD_LOGIC_VECTOR (3 downto 0);
               Immediate_Val : in STD_LOGIC_VECTOR (3 downto 0);
               Load_Select : in STD_LOGIC;
               output : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    -- Test signals
    signal AddSub_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Immediate_Val_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Load_Select_tb : STD_LOGIC := '0';
    signal output_tb : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Mux_2way_4bit port map(
        AddSub => AddSub_tb,
        Immediate_Val => Immediate_Val_tb,
        Load_Select => Load_Select_tb,
        output => output_tb
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: Load_Select = 0, select Immediate_Val
        Immediate_Val_tb <= "1010";
        AddSub_tb <= "0101";
        Load_Select_tb <= '0';
        wait for 20 ns;
        
        -- Test case 2: Load_Select = 1, select AddSub
        Load_Select_tb <= '1';
        wait for 20 ns;
        
        -- Test case 3: change inputs, Load_Select = 0 again
        Immediate_Val_tb <= "1111";
        AddSub_tb <= "0000";
        Load_Select_tb <= '0';
        wait for 20 ns;

        -- Test case 4: Load_Select = 1 again
        Load_Select_tb <= '1';
        wait for 20 ns;
        
        -- Finish simulation
        wait;
    end process;

end Behavioral;
