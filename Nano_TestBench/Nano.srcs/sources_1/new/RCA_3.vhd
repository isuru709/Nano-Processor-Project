library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_3 is
    Port (
        B      : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit memory address input
        S      : out STD_LOGIC_VECTOR(2 downto 0);  -- Next memory address output
        C_out  : out STD_LOGIC                      -- Carry out (unused in your application)
    );
end RCA_3;

architecture Behavioral of RCA_3 is
begin
    -- Optimized implementation knowing A is fixed at "001" and C_in is '0'
    -- This eliminates the need for full adders and uses minimal logic
    
    -- Bit 0: 1 + B0 (half adder behavior)
    S(0) <= not B(0);  -- Since 1 XOR B0 = NOT B0
    
    -- Bit 1: 0 + B1 + carry0 (carry0 = B0 since we're adding 1)
    S(1) <= B(1) xor B(0);
    
    -- Bit 2: 0 + B2 + carry1
    -- carry1 = B1 and B0 (from previous stage)
    S(2) <= B(2) xor (B(1) and B(0));
    
    -- Carry out (only needed for completeness)
    C_out <= B(2) and B(1) and B(0);
end Behavioral;