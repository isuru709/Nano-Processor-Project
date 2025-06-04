----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 06:03:08 PM
-- Design Name: 
-- Module Name: Instruction_Dec - Behavioral
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2023 02:59:24 PM
-- Design Name: 
-- Module Name: Instruction_Dec - Behavioral
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2023 02:59:24 PM
-- Design Name: 
-- Module Name: Instruction_Dec - Behavioral
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

entity Instruction_Dec is
    Port ( Reg_En : out STD_LOGIC_VECTOR (2 downto 0);
           Load_Select : out STD_LOGIC;
           Immediate_Val : out STD_LOGIC_VECTOR (3 downto 0);
           MuxA_Select : out STD_LOGIC_VECTOR (2 downto 0);
           MuxB_Select : out STD_LOGIC_VECTOR (2 downto 0);
           AddSub_Select : out STD_LOGIC;           
           JmpFlag : out STD_LOGIC;
           JmpAddr : out STD_LOGIC_VECTOR (2 downto 0);
           Instruct_Bus : in STD_LOGIC_VECTOR (11 downto 0);
           JumpCheck : in STD_LOGIC_VECTOR (3 downto 0));
end Instruction_Dec;

architecture Behavioral of Instruction_Dec is

begin
   process(Instruct_Bus, JumpCheck)
   begin
      
       -- for ADD intruction
       if Instruct_Bus (11 downto 10) = "00" then
           JmpFlag <= '0';
           
           MuxA_Select <= Instruct_Bus (9 downto 7);
           MuxB_Select <= Instruct_Bus (6 downto 4);
           AddSub_Select <= '0';
           Load_Select <= '0';
           Reg_En <= Instruct_Bus (9 downto 7);  -- Store the result on Register A
       
       -- for NEG intruction
       elsif Instruct_Bus (11 downto 10) = "01" then
           JmpFlag <= '0';
           
           MuxA_Select <= "000";  -- For get -B we have to set A to zero(i.e. set to Register 0) because adder perform only A+B.
           MuxB_Select <= Instruct_Bus (9 downto 7);  -- For get a negative value of a particular number, it can be only done from Mux B
           AddSub_Select <= '1';  -- Here we perform only subtraction.
           Load_Select <= '0';
           Reg_En <= Instruct_Bus (9 downto 7);  -- Store the result on Register A
           
       -- for MOV intruction
       elsif Instruct_Bus (11 downto 10) = "10" then
           JmpFlag <= '0';
           MuxA_Select <= "000";
           MuxB_Select <= "000";
           
           Immediate_Val <= Instruct_Bus (3 downto 0);
           Reg_En <= Instruct_Bus (9 downto 7);
           Load_Select <= '1';  -- Select IMMEDIATE VALUE port via 
           
       -- for JMP intruction
       else
           MuxB_Select <= "000";
           Immediate_Val <= "0000";
           Load_Select <= '1';
           Reg_En <= "000";
           
           MuxA_Select <= Instruct_Bus (9 downto 7);
           if JumpCheck = "0000" then
               JmpAddr <= Instruct_Bus (2 downto 0);
               JmpFlag <= '1';
           else
               JmpFlag <= '0';
           end if;
       end if;
   end process;
   
end Behavioral;