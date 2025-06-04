----------------------------------------------------------------------------------
-- Testbench for Add_Sub_4bit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Add_Sub_4bit is
end TB_Add_Sub_4bit;

architecture Behavioral of TB_Add_Sub_4bit is

    component Add_Sub_4bit
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            AddSubSelect : in STD_LOGIC;
            S : inout STD_LOGIC_VECTOR(3 downto 0);
            Zero : out STD_LOGIC;
            Overflow : out STD_LOGIC
        );
    end component;

    signal A_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal B_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal AddSubSelect_tb : STD_LOGIC := '0';
    signal S_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal Zero_tb : STD_LOGIC;
    signal Overflow_tb : STD_LOGIC;

begin

    UUT: Add_Sub_4bit
        port map (
            A => A_tb,
            B => B_tb,
            AddSubSelect => AddSubSelect_tb,
            S => S_tb,
            Zero => Zero_tb,
            Overflow => Overflow_tb
        );

    stim_proc: process
    begin
        -- Test Addition: 3 + 5 = 8
        A_tb <= "0011";  -- 3
        B_tb <= "0101";  -- 5
        AddSubSelect_tb <= '0'; -- Add
        wait for 20 ns;
        
        -- Test Subtraction: 7 - 2 = 5
        A_tb <= "0111";  -- 7
        B_tb <= "0010";  -- 2
        AddSubSelect_tb <= '1'; -- Subtract
        wait for 20 ns;

        -- Test Subtraction: 2 - 7 (Negative result with overflow)
        A_tb <= "0010";  -- 2
        B_tb <= "0111";  -- 7
        AddSubSelect_tb <= '1'; -- Subtract
        wait for 20 ns;

        -- Test Addition with Overflow: 8 + 9 = 17 (overflow)
        A_tb <= "1000";  -- 8
        B_tb <= "1001";  -- 9
        AddSubSelect_tb <= '0'; -- Add
        wait for 20 ns;

        -- Test Zero output: 4 - 4 = 0
        A_tb <= "0100";  -- 4
        B_tb <= "0100";  -- 4
        AddSubSelect_tb <= '1'; -- Subtract
        wait for 20 ns;

        wait;
    end process;

end Behavioral;
