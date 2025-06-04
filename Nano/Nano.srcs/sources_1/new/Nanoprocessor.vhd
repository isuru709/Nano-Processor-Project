----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 06:00:52 PM
-- Design Name: 
-- Module Name: Nanoprocessor - Behavioral
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
-- Create Date: 06/07/2023 06:43:55 PM
-- Design Name: 
-- Module Name: Nanoprocessor - Behavioral
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

entity Nanoprocessor is
    Port ( Reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           Zero_LED : out STD_LOGIC := '1';
           Overflow_LED : out STD_LOGIC;
           LED0 : out STD_LOGIC;
           LED1 : out STD_LOGIC;
           LED2 : out STD_LOGIC;
           LED3 : out STD_LOGIC;
           Anode : out STD_LOGIC_VECTOR (3 downto 0);
           S_7Seg : out STD_LOGIC_VECTOR (6 downto 0)       
    );
end Nanoprocessor;

architecture Behavioral of Nanoprocessor is

component Register_Bank is
    Port ( D_input : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_En : in STD_LOGIC_VECTOR (2 downto 0);
           Clock : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D_out0 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out1 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out2 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out3 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out4 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out5 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out6 : out STD_LOGIC_VECTOR (3 downto 0);
           D_out7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Mux_8way_4bit is
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

component Add_Sub_4bit is
    Port ( 
        A : in STD_LOGIC_VECTOR(3 downto 0);
        B : in STD_LOGIC_VECTOR(3 downto 0);
        AddSubSelect : in STD_LOGIC;
        S : inout STD_LOGIC_VECTOR(3 downto 0);
        Zero : out STD_LOGIC;
        Overflow : out STD_LOGIC
    );
end component;

component Instruction_Dec is
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
end component;

component Program_ROM is
    Port ( MemSelect : in STD_LOGIC_VECTOR (2 downto 0);
           InstructBus : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component PC_3bit is
    Port ( Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           MemorySelect : inout STD_LOGIC_VECTOR (2 downto 0);
           JumpAddr : in STD_LOGIC_VECTOR (2 downto 0);                -- If there is a jump instruction, PC set MemorrySelect as the 
           JumpFlag : in STD_LOGIC); 
end component;

component Mux_2way_4bit is
    Port ( AddSub : in STD_LOGIC_VECTOR (3 downto 0);
           Immediate_Val : in STD_LOGIC_VECTOR (3 downto 0);
           Load_Select : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Slow_Clk
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC );
end component;

component LUT_16_7 is 
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal Clk_slow : std_logic;
signal Memory_Select : std_logic_vector (2 downto 0);  -- from program counter to program ROM
signal Jump_Address : std_logic_vector (2 downto 0);  -- from instruction decoder to program counter
signal Jump_Flag : std_logic; -- from instruction decoder to program counter
signal I : std_logic_vector (11 downto 0);  -- from program ROM to instruction decoder
signal Register_Enable : std_logic_vector (2 downto 0);  -- from instruction decoder to Register Bank
signal Load_Select : std_logic; -- from instruction decoder to Mux_2way_4bit
signal Immediate_Value : std_logic_vector (3 downto 0);  -- from instruction decoder to Mux_2way_4bit
signal Mux_A_Select : std_logic_vector (2 downto 0);  -- from instruction decoder to Mux_8way_4bit(A)
signal Mux_B_Select : std_logic_vector (2 downto 0);  -- from instruction decoder to Mux_8way_4bit(B)
signal ADD_SUB_Select : std_logic; -- from instruction decoder to Add_Sub_4bit
signal Mux_A : std_logic_vector (3 downto 0);  -- from Mux_8way_4bit(A) to Add_Sub_4bit / from instruction decoder to Mux_8way_4bit(A) output
signal Mux_B : std_logic_vector (3 downto 0);  -- from Mux_8way_4bit(B) to Add_Sub_4bit
signal Add_Sub_Result : std_logic_vector (3 downto 0);  -- from Add_Sub_4bit to Mux_2way_4bit
signal Register_Input : std_logic_vector (3 downto 0);  -- from Mux_2way_4bit to Register Bank
signal R0 : std_logic_vector (3 downto 0);  -- from R0 to Mux_8way_4bit
signal R1 : std_logic_vector (3 downto 0);  -- from R1 to Mux_8way_4bit
signal R2 : std_logic_vector (3 downto 0);  -- from R2 to Mux_8way_4bit
signal R3 : std_logic_vector (3 downto 0);  -- from R3 to Mux_8way_4bit
signal R4 : std_logic_vector (3 downto 0);  -- from R4 to Mux_8way_4bit
signal R5 : std_logic_vector (3 downto 0);  -- from R5 to Mux_8way_4bit
signal R6 : std_logic_vector (3 downto 0);  -- from R6 to Mux_8way_4bit
signal R7 : std_logic_vector (3 downto 0);  -- from R7 to Mux_8way_4bit

signal S_7s : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
--signal clk_7seg : STD_LOGIC;


begin


Slow_Clock : Slow_Clk
port map (    
    Clk_in => clk,
    Clk_out => Clk_slow
);

LUT_16_7_0 : LUT_16_7
port map (    
    address => R7,
    data => S_7s
 );
 
Programming_Counter : PC_3bit
port map (
    Reset => Reset,
    Clk => Clk_slow,
    MemorySelect => Memory_Select,
    JumpAddr => Jump_Address,
    JumpFlag => Jump_Flag 
);

Program_ROM0 : Program_ROM
port map (    
    MemSelect => Memory_Select,
    InstructBus => I
);    
    
Instruction_Decoder : Instruction_Dec
port map (
    Reg_En => Register_Enable,
    Load_Select => Load_Select,
    Immediate_Val => Immediate_Value,
    MuxA_Select => Mux_A_Select,
    MuxB_Select => Mux_B_Select,
    AddSub_Select => ADD_SUB_Select,           
    JmpFlag => Jump_Flag,
    JmpAddr => Jump_Address,
    Instruct_Bus => I,
    JumpCheck => Mux_A 
);

Mux_2way_4bit0 : Mux_2way_4bit
port map (
    AddSub =>  Add_Sub_Result,
    Immediate_Val => Immediate_Value,
    Load_Select => Load_Select,
    output => Register_Input
);

Add_Sub_Unit : Add_Sub_4bit
port map (
    A => Mux_A,
    B => Mux_B,
    AddSubSelect => ADD_SUB_Select,
    S => Add_Sub_Result,
    Zero => Zero_LED,
    Overflow => Overflow_LED
);

MuxA : Mux_8way_4bit
port map (
    reg0 => R0,
    reg1 => R1,
    reg2 => R2,
    reg3 => R3,
    reg4 => R4,
    reg5 => R5,
    reg6 => R6,
    reg7 => R7,
    Reg_select => Mux_A_Select,
    output => Mux_A
);
  
MuxB : Mux_8way_4bit
port map (
    reg0 => R0,
    reg1 => R1,
    reg2 => R2,
    reg3 => R3,
    reg4 => R4,
    reg5 => R5,
    reg6 => R6,
    reg7 => R7,
    Reg_select => Mux_B_Select,
    output => Mux_B
);  

RegisterBank : Register_Bank
port map (
    D_input => Register_Input,
    Reg_En => Register_Enable,
    Clock => Clk_slow,
    Reset => Reset,
    D_out0 => R0,
    D_out1 => R1,
    D_out2 => R2,
    D_out3 => R3,
    D_out4 => R4,
    D_out5 => R5,
    D_out6 => R6,
    D_out7 => R7
);

LED0 <= R7(0);
LED1 <= R7(1);
LED2 <= R7(2);
LED3 <= R7(3);

Anode <= "1110";
S_7Seg <= S_7s; 

end Behavioral;
