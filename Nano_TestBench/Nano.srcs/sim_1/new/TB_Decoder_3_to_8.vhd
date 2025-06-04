library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Decoder_3_to_8 is
end TB_Decoder_3_to_8;

architecture Behavioral of TB_Decoder_3_to_8 is

    -- Component Declaration for Unit Under Test (UUT)
    component Decoder_3_to_8
        Port (
            I : in STD_LOGIC_VECTOR (2 downto 0);
            EN : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- Testbench signals
    signal I_tb  : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal EN_tb : STD_LOGIC := '0';
    signal Y_tb  : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Decoder_3_to_8
        port map (
            I  => I_tb,
            EN => EN_tb,
            Y  => Y_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test all inputs with Enable = '0' (Y should be 00000000)
        EN_tb <= '0';
        for i in 0 to 7 loop
            I_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;

        -- Enable the decoder and test all input combinations
        EN_tb <= '1';
        for i in 0 to 7 loop
            I_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;

        wait;
    end process;

end Behavioral;
