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
    Cout <= 1';
  end if;
  ALU_Out <= std_logic_vector(unsigned(Reg_A)+1);

elsif(Op_Sel = "0010")then
  ALU_Out <= std_logic_vector(unsigned(Reg_A)-1);'

elsif(Op_Sel = "0011")then
  if(Cin = '1')then
    temp <= std_logic_vector('0'&unsigned(Reg_A)+unsigned('0'&Reg_B+1));
  elsif(Cin = '0')then
    temp <= std_logic_vector('0'&unsigned(Reg_A)+unsigned('0'&Reg_B));
  end if;
Cout <= temp(32);
ALU_Out <= temp(31 downto 0);

elsif(Op_Sel = "0100")then
  ALU_Out <= NOT(Reg_A);

elsif(Op_Sel = "0101")then
  ALU_Out <= Reg_A AND Reg_B;

elsif(Op_Sel = "0110")then
  ALU_Out <= Reg_A OR Reg_B;

elsif(Op_Sel = "0111")then
  ALU_Out <= Reg_A XOR Reg_B;
 
elsif(Op_Sel(3 downto 2) = "10")then
   ALU_Out <= std_logic_vector(shift_right(unsigned(Reg_A)to_integer(unsigned(Reg_B))));
  
elsif(Op_Sel(3 downto 2) = "11")then
   ALU_Out <= std_logic_vector(shift_left(unsigned(Reg_A)to_integer(unsigned(Reg_B))));
   if(Reg_A(32-to_integer(unsigned(Reg_B)))='1')then
     Cout <= '1';
   end if;
end process;
end Behavioral; 
