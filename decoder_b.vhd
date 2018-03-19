--
-- VHDL Architecture my_project4_lib.decoder.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 11:02:22 03/ 1/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY decoder IS
  port( instruction : IN std_ulogic_vector(31 downto 0);
        func : out RV32I_Op;
        rs1, rs2, rd : OUT std_ulogic_vector(4 downto 0); -- register id
        rs1v, rs2v, rdv : out std_ulogic;
        --te : out std_ulogic);
        immediate : out std_ulogic_vector(31 downto 0)); --immediate value 
END ENTITY decoder;

--
ARCHITECTURE b OF decoder IS
BEGIN
process(instruction)
-- used in decode processing --
variable vopcode: RV32I_OpField;
--variable vrd: std_ulogic_vector(4 downto 0);
--variable vrs1: std_ulogic_vector(4 downto 0);
--variable vrs2: std_ulogic_vector(4 downto 0);
--variable vim: std_ulogic_vector(31 downto 0);
variable vf7: std_ulogic_vector(6 downto 0);
variable vf3: std_ulogic_vector(2 downto 0);
variable chc: std_ulogic_vector(1 downto 0);
begin
-- extract from instruction --
vopcode := instruction(6 downto 2);
rd <= instruction(11 downto 7);
rs1 <= instruction(19 downto 15);
rs2 <= instruction(24 downto 20);
vf7 := instruction(31 downto 25);
vf3 := instruction(14 downto 12);
chc := instruction(1 downto 0);

case chc is
when "11" =>
  case vopcode is
when RV32I_OP_LUI=>  --lui
    func <= LUI;
    rs1v <= '0';
    rs2v <= '0';
    rdv <= '1';
    immediate <= instruction(31 downto 12)&"000000000000";
when RV32I_OP_AUIPC => --auipc
    func <= AUIPC;
    rs1v <= '0';
    rs2v <= '0';
    rdv <= '1';
    immediate <= instruction(31 downto 12)&"000000000000";
when RV32I_OP_JAL => --jal
  func <= JAL;
  rs1v <= '0';
  rs2v <= '0';
  rdv <= '1';
  immediate <= "00000000000"&instruction(31)&instruction(19  downto 12)&instruction(20)&instruction(30 downto 21)&'0';
when RV32I_Op_JALR => --jalr
  func <= JALR;
  rs1v <= '1';
  rs2v <= '0';
  rdv <= '1';
  immediate <= "00000000000000000000"&instruction(31 downto 20);
when RV32I_Op_BRANCH => --branch
--when "11000" =>
  rs1v <= '1';
  rs2v <= '1';
  rdv <= '0';
  immediate <= "0000000000000000000"&instruction(31)&instruction(7)&instruction(30 downto 25)&instruction(11 downto 8)&'0';
  case vf3 is
  when RV32I_FN3_BRANCH_EQ =>
    func <= BEQ;
  when RV32I_FN3_BRANCH_NE =>
    func <= BNE;
  when RV32I_FN3_BRANCH_LT =>
    func <=BLT;
  when RV32I_FN3_BRANCH_GE =>
    func <= BGE;
  when RV32I_FN3_BRANCH_LTU =>
    func <= BLTU;
  when RV32I_FN3_BRANCH_GEU =>
    func <= BGEU;
  when others =>
    rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
  end case;
when RV32I_OP_LOAD => --load
  rdv <= '1';
  rs1v <= '1';
  rs2v <= '0';
  immediate <= "00000000000000000000"&instruction(31 downto 20);
  case vf3 is
  when RV32I_FN3_LOAD_B =>
  func <= LB;
  when RV32I_FN3_LOAD_H =>
  func <= LH;
  when RV32I_FN3_LOAD_W =>
  func <= LW;
  when RV32I_FN3_LOAD_BU =>
  func <= LBU;
  when RV32I_FN3_LOAD_HU =>
  func <= LHU;
  when others =>
  rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;  
  end case;
when RV32I_OP_STORE => --store
  rs1v <= '1';
  rs2v <= '1';
  rdv <= '0';
  immediate <= "00000000000000000000"&instruction(31 downto 25)&instruction(11 downto 7);
  case vf3 is
  when RV32I_FN3_STORE_B =>
  func <= SB;
  when RV32I_FN3_STORE_H =>
  func <= SH;
  when RV32I_FN3_STORE_W =>
  func <= SW;
  when others =>
  end case;
when RV32I_OP_ALUI => --alui
  rdv <= '1';
  rs1v <= '1';
  rs2v <= '0';
  case vf3 is
    -- XORI, ORI, ANDI, SLLI, SRLI, SRAI,
  when RV32I_FN3_ALU_ADD =>
    immediate <= "00000000000000000000"&instruction(31 downto 20);
    func <= ADDI;
  when RV32I_FN3_ALU_SLT =>
    immediate <= "00000000000000000000"&instruction(31 downto 20);
    func <= SLTI;
  when RV32I_FN3_ALU_SLTU =>
    immediate <= "00000000000000000000"&instruction(31 downto 20);
    func <= SLTIU;
  when RV32I_FN3_ALU_XOR =>
    immediate <= "00000000000000000000"&instruction(31 downto 20);
    func <= XORI;
  when RV32I_FN3_ALU_OR =>
    immediate <= "00000000000000000000"&instruction(31 downto 20);
    func <= ORI;
  when RV32I_FN3_ALU_AND =>
    immediate <= "00000000000000000000"&instruction(31 downto 20);
    func <= ANDI;
  when RV32I_FN3_ALU_SLL =>
    immediate <= "000000000000000000000000000"&instruction(24 downto 20);
    func <= SLLI;
  when RV32I_FN3_ALU_SRL =>
    case vf7 is
    when RV32I_FN7_ALU => --0000000
      immediate <= "000000000000000000000000000"&instruction(24 downto 20);
      func <= SRLI;
    when RV32I_FN7_ALU_SA => --0100000
      immediate <= "000000000000000000000000000"&instruction(24 downto 20);
      func <= SRAI;
    when others =>
      rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
    end case;
    
  when others =>
    rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
  end case;

when RV32I_OP_ALU => --alu
-- ADDr, SUBr, SLLr, SLTr, SLTUr, XORr, SRLr, SRAr, ORr, ANDr
  rdv <= '1';
  rs1v <= '1';
  rs2v <= '1';
  immediate <= (others => '0');
  case vf3 is
  when RV32I_FN3_ALU_ADD =>
    case vf7 is
    when RV32I_FN7_ALU =>
      func <=ADDr;
    when RV32I_FN7_ALU_SA =>
      func <= SUBr;
    when others =>
      rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
    end case;
  when RV32I_FN3_ALU_SLL =>
    func <= SLLr;
  when RV32I_FN3_ALU_SLT =>
    func <= SLTr;
  when RV32I_FN3_ALU_SLTU =>
    func <= SLTUr;
  when RV32I_FN3_ALU_XOR =>
    func <= XORr;
  when RV32I_FN3_ALU_SRA =>
    case vf7 is
    when RV32I_FN7_ALU => --0000000
      func <= SRLr;
    when RV32I_FN7_ALU_SA => --0100000
      func <= SRAr;
    when others =>
      rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
    end case;
  when RV32I_FN3_ALU_OR =>
    func <= ORr;
  when RV32I_FN3_ALU_AND =>
    func <= ANDr;
  when others =>
    rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
  end case;
when others =>
  rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
end case;
when others =>
  rs1v <= '0';
  rs2v <= '0';
  rdv <= '0';
  func <= BAD;
end case;
end process;
END ARCHITECTURE b;

