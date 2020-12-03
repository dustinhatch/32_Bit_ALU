library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ALU_tb is
end;

architecture bench of ALU_tb is 

component ALU
  Port(
    Reg_A   :in std_logic_vector(31 downto 0);
    Reg_B   :in std_logic_vector(31 downto 0);
    Op_Sel  :in std_logic_vector(3 downto 0);
    Cin     :in std_logic;
    Cout    :out std_logic;
    ALU_Out :out std_logic_vector(31 downto 0)
);

end component;

signal Reg_A   : std_logic_vector(31 downto 0);
signal Reg_B   : std_logic_vector(31 downto 0);
signal Op_Sel  : std_logic_vector(3 downto 0);
signal Cin     : std_logic;
signal Cout    : std_logic;
signal ALU_Out : std_logic_vector(31 downto 0)
  
begin
  
uut: ALU port map(Reg_A => Reg_A,
                  Reg_B => Reg_B,
                  Op_Sel => Op_Sel,
                  Cin => Cin,
                  Cout => Cout,
                  ALU_Out => ALU_Out);
  
stimulus:process
begin
  
-- Transfer, ALU_Out = xFFFFFFFF
Reg_A <= x"FFFFFFFF";
Reg_B <= x"00000000";
Cin <= '0';
Op_Sel <= "0000";
wait for 20ns;

-- Increment, ALU_Out = x00000001 and Cout = 0
Reg_A <= x"00000000";
OpSel <= "0001";
wait for 20 ns;
  
-- Increment, ALU_Out = x00000000 and Cout = 1
Reg_A <= x"FFFFFFFF";
OpSel <= "0001";
wait for 20 ns;
  
-- Decrement, ALU_Out = xFFFFFFFE
Reg_A <= x"FFFFFFFF";
Sel_Op <= "0010";
wait for 20ns;

-- Addition, Cin = 0 and ALU_Out = xFFFFFFFF and Cout = 0
Reg_A <= x"FFFF0000";
Reg_B <= x"0000FFFF";
Cin <= '0';
Op_Sel <= "0011";
wait for 20ns;

-- Addition, Cin = 1 and ALU_Out = x00000000 and Cout = 1
Reg_A <= x"FFFF0000";
Reg_B <= x"0000FFFF";
Cin <= '1';
Op_Sel <= "0011";
wait for 20ns;
  
-- NOT, ALU_Out = x00000000
Reg_A <= x"FFFFFFFF";
Op_Sel <= "0100";
wait for 20ns;

-- AND, ALU_Out = x00000000
Reg_A <= x"FFFF0000";
Reg_B <= x"0000FFFF";
Op_Sel <= "0101";
wait for 20ns;
  
-- OR, ALU_Out = xFFFFFFFF
Reg_A <= x"FFFF0000";
Reg_B <= x"0000FFFF";
Op_Sel <= "0110";
wait for 20ns;
 
-- XOR, ALU_Out = x00FF00FF
