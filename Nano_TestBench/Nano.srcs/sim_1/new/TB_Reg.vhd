library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Reg is
end TB_Reg;

architecture Behavioral of TB_Reg is

    -- Component Declaration for the Unit Under Test (UUT)
    component Reg
        Port (
            D     : in  STD_LOGIC_VECTOR(3 downto 0);
            En    : in  STD_LOGIC;
            Clk   : in  STD_LOGIC;
            Reset : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Testbench signals
    signal D_tb     : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal En_tb    : STD_LOGIC := '0';
    signal Clk_tb   : STD_LOGIC := '0';
    signal Reset_tb : STD_LOGIC := '0';
    signal Q_tb     : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock generation process (10 ns period)
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Reg
        port map (
            D     => D_tb,
            En    => En_tb,
            Clk   => Clk_tb,
            Reset => Reset_tb,
            Q     => Q_tb
        );

    -- Clock process
    clk_process: process
    begin
        while true loop
            Clk_tb <= '0';
            wait for clk_period / 2;
            Clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the register
        Reset_tb <= '1';
        wait for clk_period;
        Reset_tb <= '0';

        -- Test: Write 5 when En=1
        D_tb <= "0101";
        En_tb <= '1';
        wait for clk_period;

        -- Test: Change D to 9, but En=0 (Q should remain 5)
        D_tb <= "1001";
        En_tb <= '0';
        wait for clk_period;

        -- Test: Enable again, Q should update to 9
        En_tb <= '1';
        wait for clk_period;

        -- Reset again
        Reset_tb <= '1';
        wait for clk_period;
        Reset_tb <= '0';

        wait;
    end process;

end Behavioral;
