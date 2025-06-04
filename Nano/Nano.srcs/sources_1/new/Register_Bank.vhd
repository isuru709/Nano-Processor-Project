----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 03:21:00 PM
-- Design Name: 
-- Module Name: Register_Bank - Behavioral
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

entity Register_Bank is
    Port ( D_input : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_En : in STD_LOGIC_VECTOR (2 downto 0);
           Clock : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D_out0 : out STD_LOGIC_VECTOR (3 downto 0):= "0000";
           D_out1 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out2 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out3 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out4 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out5 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out6 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out7 : out STD_LOGIC_VECTOR (3 downto 0));
end Register_Bank;

architecture Behavioral of Register_Bank is

    component Decoder_3_to_8 is
        Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
               EN : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
   --####################THIS REG D FLIP FLOP MUST HAVE a reset PIN. ADD THIS FOR COMPLETION 
    component Reg is
        Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
               En : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Reset : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

signal y : STD_LOGIC_VECTOR (7 downto 0);

begin
    decoder : Decoder_3_to_8
    port map (
        I => Reg_En,
        En => '1',
        Y => y );
    
    Reg0 : Reg
    port map (
        D => D_input,
        En =>'0',
        Clk => Clock,
        Reset => Reset,
        Q => D_out0  );
    
    Reg1 : Reg
    port map (
        D => D_input,
        En => y(1),
        Clk => Clock,
        Reset => Reset,
        Q => D_out1 );
        
     Reg2 : Reg
     port map (
        D => D_input,
        En => y(2),
        Clk => Clock,
        Reset => Reset,
        Q => D_out2 );
            
     Reg3 : Reg
     port map (
        D => D_input,
        En => y(3),
        Clk => Clock,
        Reset => Reset,
        Q => D_out3 );
                
     Reg4 : Reg
     port map (
        D => D_input,
        En => y(4),
        Clk => Clock,
        Reset => Reset,
        Q => D_out4 );
                    
     Reg5 : Reg
     port map (
        D => D_input,
        En => y(5),
        Clk => Clock,
        Reset => Reset,
        Q => D_out5 );
     
     Reg6 : Reg
     port map (
        D => D_input,
        En => y(6),
        Clk => Clock,
        Reset => Reset,
        Q => D_out6 );
                            
     Reg7 : Reg
     port map (
        D => D_input,
        En => y(7),
        Clk => Clock,
        Reset => Reset,
        Q => D_out7 ); 

end Behavioral;