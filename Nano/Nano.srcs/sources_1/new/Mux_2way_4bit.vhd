----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 03:35:18 PM
-- Design Name: 
-- Module Name: Mux_2way_4bit - Behavioral
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

entity Mux_2way_4bit is
    Port ( AddSub : in STD_LOGIC_VECTOR (3 downto 0);
           Immediate_Val : in STD_LOGIC_VECTOR (3 downto 0);
           Load_Select : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_2way_4bit;

architecture Behavioral of Mux_2way_4bit is

COMPONENT Mux_2_to_1
PORT ( D : in STD_LOGIC_VECTOR (1 downto 0);
       S : in STD_LOGIC;
       Y : out STD_LOGIC);
END COMPONENT;

begin
    Mux_0: Mux_2_to_1 port map(
        D(1) => AddSub(0),
        D(0) => Immediate_Val(0),
        S => Load_Select,
        Y => output(0) 
    );
    
    Mux_1: Mux_2_to_1 port map(
        D(1) => AddSub(1),
        D(0) => Immediate_Val(1),
        S => Load_Select,
        Y => output(1) 
    );
    
    Mux_2: Mux_2_to_1 port map(
        D(1) => AddSub(2),
        D(0) => Immediate_Val(2),
        S => Load_Select,
        Y => output(2) 
    );    
    
    Mux_3: Mux_2_to_1 port map(
        D(1) => AddSub(3),
        D(0) => Immediate_Val(3),
        S => Load_Select,
        Y => output(3) 
    );  

end Behavioral;