--
-- VHDL Architecture my_project4_lib.alu.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 10:39:14 03/22/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE work.RV32I.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

ENTITY alu IS
  port( in_a, in_b : in std_ulogic_vector(31 downto 0);
    --sel: in std_ulogic_vector(2 downto 0);
    sel : in ALU_Op;
    q: out std_ulogic_vector(31 downto 0);
    flagq: out std_ulogic
);
END ENTITY alu;

--
ARCHITECTURE b OF alu IS
  


BEGIN
process(in_a, in_b, sel,q)

variable valucode: RV32I_ALUField;


begin
--aADD, aSUB, aAND, aOR, aXOR, sSL, aSRL, sSRA

case sel is
when aADD =>
  q <= in_a + in_b;
when aSUB =>
  q <= in_b - in_a;
when aAND => --and
  q <= in_a and in_b;
when aOR => --or
  q <= in_a or in_b;
when aXOR => --xor
  q <= in_a xor in_b;
when sSL => --sl
  q <= std_ulogic_vector(unsigned(in_a) sll to_integer(unsigned(in_b(4 downto 0))));
--should use signed or unsigned here
when aSRL => --srl
  q <= std_ulogic_vector(unsigned(in_a) srl to_integer(unsigned(in_b(4 downto 0))));
when sSRA => --sra
  q <= std_ulogic_vector(signed(in_a) sra to_integer(unsigned(in_b(4 downto 0))));
--Type of shift depends on input to function. Unsigned=Logical, Signed=Arithmetic
when others =>
  NULL;
end case;


--valucode := sel;  
--case valucode is
--when RV32I_ALU_ADD => --ADD
--  q <= std_ulogic_vector(tem);
--when RV32I_ALU_SUB => --sub
--  q <= in_b - in_a;
--  --q <= std_ulogic_vector(tem);
--when RV32I_ALU_AND => --and
--  q <= in_a and in_b;
--when RV32I_ALU_OR => --or
--  q <= in_a or in_b;
--when RV32I_ALU_XOR => --xor
--  q <= in_a xor in_b;
--when RV32I_ALU_SL => --sl
--  q <= std_ulogic_vector(unsigned(in_a) sll to_integer(unsigned(in_b)));
----should use signed or unsigned here
--when RV32I_ALU_SRL => --srl
--  q <= std_ulogic_vector(unsigned(in_a) srl to_integer(unsigned(in_b)));
--
--when RV32I_ALU_SRA => --sra
--  q <= std_ulogic_vector(signed(in_a) sra to_integer(unsigned(in_b)));
----Type of shift depends on input to function. Unsigned=Logical, Signed=Arithmetic
--when others =>
--  NULL;
--end case;

case q is
when "00000000000000000000000000000000" =>
  flagq <= '1';
when others =>
  flagq <= '0';
end case;

end process;

END ARCHITECTURE b;

--http://www.fpga4student.com/2017/06/vhdl-code-for-arithmetic-logic-unit-alu.html

