----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 03:48:55 PM
-- Design Name: 
-- Module Name: Program_ROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_ROM is
    Port ( MemSelect : in STD_LOGIC_VECTOR (2 downto 0);
           InstructBus : out STD_LOGIC_VECTOR (11 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is
    
    type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
        signal Assembly_Code : rom_type := (
                    "101110000000", -- 0    MOV R7, 0
                    "100010000001", -- 1    MOV R1, 1
                    "100100000010", -- 2    MOV R2, 2
                    "100110000011", -- 3    MOV R3, 3
                    "001110010000", -- 4    ADD R7, R1
                    "001110100000", -- 5    ADD R7, R2
                    "001110110000", -- 6    ADD R7, R3
                    "110000000111"  -- 7    JZR R0, 7
         );
begin
    InstructBus <= Assembly_Code(to_integer(unsigned(MemSelect)));
end Behavioral;