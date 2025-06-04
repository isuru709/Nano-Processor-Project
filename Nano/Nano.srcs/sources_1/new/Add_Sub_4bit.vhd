library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Add_Sub_4bit is
    Port (
        A           : in  STD_LOGIC_VECTOR(3 downto 0);
        B           : in  STD_LOGIC_VECTOR(3 downto 0);
        AddSubSelect: in  STD_LOGIC;  -- '0' for add, '1' for subtract
        S           : inout STD_LOGIC_VECTOR(3 downto 0);
        Zero        : out STD_LOGIC;
        Overflow    : out STD_LOGIC
    );
end Add_Sub_4bit;

architecture Behavioral of Add_Sub_4bit is
    signal b_operand   : STD_LOGIC_VECTOR(3 downto 0);
    signal sum_ext     : UNSIGNED(4 downto 0);  -- Extended sum including carry
begin
    -- Operation selection (minimizes LUT usage)
    b_operand <= B when AddSubSelect = '0' else not B;
    
    -- Single adder handles both operations
    sum_ext <= unsigned('0' & A) + unsigned('0' & b_operand) + ("" & AddSubSelect);
    
    -- Connect outputs
    S <= std_logic_vector(sum_ext(3 downto 0));
    
    -- Zero detection (uses result bits directly)
    Zero <= '1' when sum_ext(3 downto 0) = "0000" else '0';
    
    -- Optimized overflow detection
    Overflow <= (A(3) and b_operand(3) and not S(3)) or 
                (not A(3) and not b_operand(3) and S(3));
end Behavioral;