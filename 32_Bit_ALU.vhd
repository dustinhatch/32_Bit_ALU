--Module Name: 32_Bit_ALU - Behavioral

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is 
  Port(
    Reg_A   :in std_logic_vector(31 downto 0);
    Reg_B   :in std_logic_vector(31 downto 0);
    Op_Sel  :in std_logic_vector(3 downto 0);
    Cin     :in std_logic;
    Cout    :out std_logic;
    ALU_Out :out std_logic_vector(31 downto 0);
);

end ALU;

architecture Behavioral of ALU is

signal temp:std_logic_vector(32 downto 0);

begin

process(Reg_A, Reg_B, OP_Sel, Cin) begin

Cout <= '0';
temp <= "00000000000000000000000000000000";

if(Op_Sel = "0000") then
  ALU_Out<=Reg_A;

elsif(Op_Sel = "0001") then
  if(Reg_A = x"FFFFFFFF")then
    Cout<='1';
  end if;
  ALU_Out <= std_logic_vector(unsigned(Reg_A)+1);

elsif
