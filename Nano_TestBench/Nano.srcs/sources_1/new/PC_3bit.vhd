library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_3bit is
    Port (
        Reset        : in  STD_LOGIC;
        Clk          : in  STD_LOGIC;
        MemorySelect : out STD_LOGIC_VECTOR(2 downto 0);
        JumpAddr     : in  STD_LOGIC_VECTOR(2 downto 0);
        JumpFlag     : in  STD_LOGIC
    );
end PC_3bit;

architecture Behavioral of PC_3bit is
    signal PC_reg : std_logic_vector(2 downto 0) := "000";
    
begin
    process(Clk, Reset)
    begin
        if Reset = '1' then
            PC_reg <= "000";
        elsif rising_edge(Clk) then
            if JumpFlag = '1' then
                PC_reg <= JumpAddr;
            else
                case PC_reg is
                    when "000" => PC_reg <= "001";
                    when "001" => PC_reg <= "010";
                    when "010" => PC_reg <= "011";
                    when "011" => PC_reg <= "100";
                    when "100" => PC_reg <= "101";
                    when "101" => PC_reg <= "110";
                    when "110" => PC_reg <= "111";
                    when others => PC_reg <= "000";
                end case;
            end if;
        end if;
    end process;

    MemorySelect <= PC_reg;
end Behavioral;