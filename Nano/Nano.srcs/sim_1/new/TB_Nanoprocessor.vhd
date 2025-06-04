library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_TEXTIO.all; -- For hwrite
use STD.TEXTIO.all;           -- For file operations

entity TB_Nanoprocessor is
end TB_Nanoprocessor;

architecture Behavioral of TB_Nanoprocessor is

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

    -- Signals
    signal clk          : STD_LOGIC := '0';
    signal reset        : STD_LOGIC := '1';
    signal zero_led     : STD_LOGIC;
    signal overflow_led : STD_LOGIC;
    signal led0, led1, led2, led3 : STD_LOGIC;
    signal anode        : STD_LOGIC_VECTOR(3 downto 0);
    signal s_7seg       : STD_LOGIC_VECTOR(6 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;
    
    -- Simulation control
    signal sim_finished : boolean := false;

    -- Function to convert std_logic_vector to string
    function vec2str(vec: std_logic_vector) return string is
        variable result: string(1 to vec'length);
    begin
        for i in vec'range loop
            result(i+1) := std_logic'image(vec(i))(2);
        end loop;
        return result;
    end function;

begin

    -- Instantiate Unit Under Test
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

    -- Clock generation
    clk_process: process
    begin
        while not sim_finished loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Allow enough time for all 8 instructions to execute
        wait for 80 * clk_period;
        
        wait for 10 ns;
        
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        wait for 80 * clk_period;
        -- Check final outputs
        wait for 10 ns;

        wait;
    end process;

end Behavioral;