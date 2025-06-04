----------------------------------------------------------------------------------
-- Testbench for Mux_8way_4bit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TB_Mux_8way_4bit is
end TB_Mux_8way_4bit;

architecture Behavioral of TB_Mux_8way_4bit is

    component Mux_8way_4bit
        Port (  reg0 : in STD_LOGIC_VECTOR (3 downto 0);
                reg1 : in STD_LOGIC_VECTOR (3 downto 0);
                reg2 : in STD_LOGIC_VECTOR (3 downto 0);
                reg3 : in STD_LOGIC_VECTOR (3 downto 0);
                reg4 : in STD_LOGIC_VECTOR (3 downto 0);
                reg5 : in STD_LOGIC_VECTOR (3 downto 0);
                reg6 : in STD_LOGIC_VECTOR (3 downto 0);
                reg7 : in STD_LOGIC_VECTOR (3 downto 0);
                Reg_select : in STD_LOGIC_VECTOR (2 downto 0);
                output : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal reg0_tb, reg1_tb, reg2_tb, reg3_tb, reg4_tb, reg5_tb, reg6_tb, reg7_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal Reg_select_tb : STD_LOGIC_VECTOR(2 downto 0);
    signal output_tb : STD_LOGIC_VECTOR(3 downto 0);

begin

    UUT: Mux_8way_4bit
        port map(
            reg0 => reg0_tb,
            reg1 => reg1_tb,
            reg2 => reg2_tb,
            reg3 => reg3_tb,
            reg4 => reg4_tb,
            reg5 => reg5_tb,
            reg6 => reg6_tb,
            reg7 => reg7_tb,
            Reg_select => Reg_select_tb,
            output => output_tb
        );

    stim_proc: process
    begin
        -- Initialize all inputs
        reg0_tb <= "0000";
        reg1_tb <= "0001";
        reg2_tb <= "0010";
        reg3_tb <= "0011";
        reg4_tb <= "0100";
        reg5_tb <= "0101";
        reg6_tb <= "0110";
        reg7_tb <= "0111";

        -- Test all select lines
        for i in 0 to 7 loop
            Reg_select_tb <= std_logic_vector(to_unsigned(i, 3));
            wait for 20 ns;
        end loop;

        wait;
    end process;

end Behavioral;
