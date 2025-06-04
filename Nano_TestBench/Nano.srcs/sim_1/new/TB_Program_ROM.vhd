library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Program_ROM is
end TB_Program_ROM;

architecture Behavioral of TB_Program_ROM is

    -- Component declaration for the Unit Under Test (UUT)
    component Program_ROM
        Port (
            MemSelect : in STD_LOGIC_VECTOR(2 downto 0);
            InstructBus : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    -- Testbench signals
    signal MemSelect_tb : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal InstructBus_tb : STD_LOGIC_VECTOR(11 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Program_ROM
        port map (
            MemSelect => MemSelect_tb,
            InstructBus => InstructBus_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Iterate over all 8 memory addresses (000 to 111)
        for i in 0 to 7 loop
            MemSelect_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;

        wait;
    end process;

end Behavioral;
