--
-- VHDL Architecture my_project4_lib.decodercontrol.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 21:37:31 03/17/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY decodercontrol IS
port(func : in RV32I_Op;
    leftc, extrac : out std_ulogic_vector(1 downto 0);
    rightc : out std_ulogic
);
END ENTITY decodercontrol;
--
ARCHITECTURE b OF decodercontrol IS
BEGIN
process(func)
begin
    if(func /= BAD and func /= NOP) then
        if (func = LUI) then
            extrac <= "00";
        elsif (func = AUIPC) then
            leftc <= "00";
            rightc <= '0';
        elsif (func = JAL) then
            leftc <= "01";
            extrac <= "00";
        elsif (func = JALR) then
            leftc <= "10";
            rightc <= '0';
            extrac <= "01";
        elsif (func = BEQ or func = BNE or func = BLT or func = BGE or func = BLTU or func = BGEU ) then
            leftc <= "10";
            rightc <= '1';
            extrac <= "10";
        elsif (func = LB or func = LH or func = LW or func = LBU or func = LHU) then
            leftc <= "10";
            rightc <= '0';
        elsif (func = SB or func = SH or func = SW ) then
            leftc <= "10";
            rightc <= '0';
            extrac <= "11";
        elsif (func = ADDI or func = SLTI or func = SLTIU or func = XORI or func = ORI or func = ANDI or func = SLLI or func = SRLI or func = SRAI) then
            leftc <= "10";
            rightc <= '0';
        elsif (func = ADDr or func = SUBr or func = SLLr or func = SLTr or func = SLTUr or func = XORr or func = SRLr or func = SRAr or func = ORr or func = ANDr ) then
            leftc <= "10";
            rightc <= '1';
        end if;
        end if;
        end process;


END ARCHITECTURE b;