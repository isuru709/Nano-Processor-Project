----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 03:39:11 PM
-- Design Name: 
-- Module Name: Mux_2way_3bit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_2way_3bit is
    Port ( jmp_adrs : in STD_LOGIC_VECTOR (2 downto 0);
           adder_3bit : in STD_LOGIC_VECTOR (2 downto 0);
           jmp_flag : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (2 downto 0));
end Mux_2way_3bit;

architecture Behavioral of Mux_2way_3bit is
    COMPONENT Mux_2_to_1
    PORT ( D : in STD_LOGIC_VECTOR (1 downto 0);
           S : in STD_LOGIC;
           Y : out STD_LOGIC);
    END COMPONENT;
    
begin
    Mux_0: Mux_2_to_1 port map(
        D(0) => jmp_adrs(0),
        D(1) => adder_3bit(0),
        S => jmp_flag,
        Y => output(0) 
    );
    
    Mux_1: Mux_2_to_1 port map(
        D(0) => jmp_adrs(1),
        D(1) => adder_3bit(1),
        S => jmp_flag,
        Y => output(1) 
    );

    Mux_2: Mux_2_to_1 port map(
        D(0) => jmp_adrs(2),
        D(1) => adder_3bit(2),
        S => jmp_flag,
        Y => output(2) 
    );    
    

end Behavioral;