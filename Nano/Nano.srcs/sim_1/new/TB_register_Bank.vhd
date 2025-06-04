library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Register_Bank is
-- No ports for testbench
end TB_Register_Bank;

architecture Behavioral of TB_Register_Bank is

    -- Component declaration of your Register_Bank
    component Register_Bank is
        Port ( D_input : in STD_LOGIC_VECTOR (3 downto 0);
               Reg_En : in STD_LOGIC_VECTOR (2 downto 0);
               Clock : in STD_LOGIC;
               Reset : in STD_LOGIC;
               D_out0 : out STD_LOGIC_VECTOR (3 downto 0);
               D_out1 : out STD_LOGIC_VECTOR (3 downto 0);
               D_out2 : out STD_LOGIC_VECTOR (3 downto 0);
               D_out3 : out STD_LOGIC_VECTOR (3 downto 0);
               D_out4 : out STD_LOGIC_VECTOR (3 downto 0);
               D_out5 : out STD_LOGIC_VECTOR (3 downto 0);
               D_out6 : out STD_LOGIC_VECTOR (3 downto 0);
               D_out7 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    -- Signals to connect to the DUT
    signal D_input_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Reg_En_tb : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Clock_tb : STD_LOGIC := '0';
    signal Reset_tb : STD_LOGIC := '0';

    signal D_out0_tb, D_out1_tb, D_out2_tb, D_out3_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal D_out4_tb, D_out5_tb, D_out6_tb, D_out7_tb : STD_LOGIC_VECTOR(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Register Bank
    DUT: Register_Bank
        port map(
            D_input => D_input_tb,
            Reg_En => Reg_En_tb,
            Clock => Clock_tb,
            Reset => Reset_tb,
            D_out0 => D_out0_tb,
            D_out1 => D_out1_tb,
            D_out2 => D_out2_tb,
            D_out3 => D_out3_tb,
            D_out4 => D_out4_tb,
            D_out5 => D_out5_tb,
            D_out6 => D_out6_tb,
            D_out7 => D_out7_tb
        );

    -- Clock generation
    Clock_process : process
    begin
        while true loop
            Clock_tb <= '0';
            wait for clk_period/2;
            Clock_tb <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Apply reset
        Reset_tb <= '1';
        wait for clk_period * 2;
        Reset_tb <= '0';

        -- Write 4'b1010 to register 0
        D_input_tb <= "1010";
        Reg_En_tb <= "000"; -- Enable register 0
        wait for clk_period * 2;

        -- Write 4'b0101 to register 1
        D_input_tb <= "0101";
        Reg_En_tb <= "001"; -- Enable register 1
        wait for clk_period * 2;

        -- Write 4'b1111 to register 7
        D_input_tb <= "1111";
        Reg_En_tb <= "111"; -- Enable register 7
        wait for clk_period * 2;

        -- Disable all register writes
        Reg_En_tb <= "000";

        -- Wait a bit to observe outputs
        wait for clk_period * 5;

        -- Finish simulation
        wait;
    end process;

end Behavioral;
