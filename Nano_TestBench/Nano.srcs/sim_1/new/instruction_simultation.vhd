library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Instruction_Decoder is
end TB_Instruction_Decoder;

architecture Behavioral of TB_Instruction_Decoder is

    -- Component Declaration
    component Instruction_Dec
        Port (
            Reg_En        : out STD_LOGIC_VECTOR (2 downto 0);
            Load_Select   : out STD_LOGIC;
            Immediate_Val : out STD_LOGIC_VECTOR (3 downto 0);
            MuxA_Select   : out STD_LOGIC_VECTOR (2 downto 0);
            MuxB_Select   : out STD_LOGIC_VECTOR (2 downto 0);
            AddSub_Select : out STD_LOGIC;
            JmpFlag       : out STD_LOGIC;
            JmpAddr       : out STD_LOGIC_VECTOR (2 downto 0);
            Instruct_Bus  : in STD_LOGIC_VECTOR (11 downto 0);
            JumpCheck     : in STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals
    signal Reg_En        : STD_LOGIC_VECTOR (2 downto 0);
    signal Load_Select   : STD_LOGIC;
    signal Immediate_Val : STD_LOGIC_VECTOR (3 downto 0);
    signal MuxA_Select   : STD_LOGIC_VECTOR (2 downto 0);
    signal MuxB_Select   : STD_LOGIC_VECTOR (2 downto 0);
    signal AddSub_Select : STD_LOGIC;
    signal JmpFlag       : STD_LOGIC;
    signal JmpAddr       : STD_LOGIC_VECTOR (2 downto 0);
    signal Instruct_Bus  : STD_LOGIC_VECTOR (11 downto 0);
    signal JumpCheck     : STD_LOGIC_VECTOR (3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Instruction_Dec
        Port Map (
            Reg_En        => Reg_En,
            Load_Select   => Load_Select,
            Immediate_Val => Immediate_Val,
            MuxA_Select   => MuxA_Select,
            MuxB_Select   => MuxB_Select,
            AddSub_Select => AddSub_Select,
            JmpFlag       => JmpFlag,
            JmpAddr       => JmpAddr,
            Instruct_Bus  => Instruct_Bus,
            JumpCheck     => JumpCheck
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test ADD (opcode "00"), A=001, B=010
        Instruct_Bus <= "00" & "001" & "010" & "0000";  -- 2 + 3 + 3 + 4 = 12 bits
        JumpCheck <= "0000";
        wait for 100 ns;

        -- Test NEG (opcode "01"), B=011
        Instruct_Bus <= "01" & "011" & "000" & "0000";  -- A = unused here
        wait for 100 ns;

        -- Test MOV (opcode "10"), Reg=100, Imm=1100
        Instruct_Bus <= "10" & "100" & "000" & "1100";
        wait for 100 ns;

        -- Test JMP with JumpCheck = 0000 (should jump), A=101, Addr=011
        Instruct_Bus <= "11" & "101" & "000" & "0011";
        JumpCheck <= "0000";
        wait for 100 ns;

        -- Test JMP with JumpCheck ? 0000 (no jump), A=110, Addr=101
        Instruct_Bus <= "11" & "110" & "000" & "0101";
        JumpCheck <= "1111";
        wait for 100 ns;

        wait;
    end process;

end Behavioral;
