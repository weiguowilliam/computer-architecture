--
-- VHDL Architecture my_project4_lib.decoderp.s
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 19:44:46 03/16/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
--hybrid version of decoderpipeline
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY decoderp IS
  port( instruction : IN std_ulogic_vector(31 downto 0);
        pc : IN std_ulogic_vector(31 downto 0);
        rfda, rfdb : IN std_ulogic_vector(31 downto 0);
        left, right, extra : OUT std_ulogic_vector(31 downto 0);
        rfaa, rfab, dest : OUT std_ulogic_vector(4 downto 0);
        func : OUT RV32I_Op);
END ENTITY decoderp;

--
ARCHITECTURE s OF decoderp IS
signal rs1o, rs2o, rdo : std_ulogic_vector(4 downto 0);
signal immediateo, instr, pcc : std_ulogic_vector(31 downto 0);
signal rs1vo, rs2vo, rdvo, clock : std_ulogic;
signal funco : RV32I_Op;
signal Oinc, Oinc2 : std_ulogic_vector(31 downto 0);

--variable sum : UNSIGNED(31 downto 0);
  
BEGIN

regins: entity work.reg(b)
    port map(clock => clock, reset=> '0',enable=>'1',d=>instruction,q=>instr);

    regpc: entity work.reg(b)
    port map(clock => clock, reset=> '0',enable=>'1',d=>pc,q=>pcc);

  decoder: entity work.decoder(b)
    port map(instruction=>instr, func=>funco, rs1=>rs1o, rs2=>rs2o,rd=>rdo,rs1v=>rs1vo,rs2v=>rs2vo,rdv=>rdvo,immediate=>immediateo);

  inc: entity work.inc(b)
    port map(d0 => instr, d1 => pcc, q => Oinc);
  
  inc2: entity work.inc(b)
    port map(d0 => pcc, d1 =>"00000000000000000000000000000100", q => Oinc2);

  


func <= funco;
rfaa <= rs1o;
rfab <= rs2o;
dest <= rdo;

--right <= rfda when s-type & i-type & b-type & r-type & jalr
--      <= pc when auipc
--      <= pc + 4 when jal
right <= rfda when func = LB or func = LH or func = LW or func = LBU or func = LHU or func = SB or func = SH or func = SW 
      or func = ADDI or func = SLTI or func = SLTIU or func = XORI or func = ORI or func = ANDI or func = SLLI or func = SRLI or func = SRAI
      or func = BEQ or func = BNE or func = BLT or func = BGE or func = BLTU or func = BGEU
      or func = ADDr or func = SUBr or func = SLLr or func = SLTr or func = SLTUr or func = XORr or func = SRLr or func = SRAr or func = ORr or func = ANDr 
      or func = JALR else
      pcc when func = AUIPC else
      Oinc2 when func = JAL;

      
--right <= rfdb when b-type& r-type
--      <= immediate when s-type & i-type & u-type & j-type
left <= immediateo when func = LB or func = LH or func = LW or func = LBU or func = LHU or func = SB or func = SH or func = SW 
      or func = ADDI or func = SLTI or func = SLTIU or func = XORI or func = ORI or func = ANDI or func = SLLI or func = SRLI or func = SRAI
      or func = LUI  or func = AUIPC  
      or func = JAL or func = JALR else
      rfdb when func =  BEQ or func = BNE or func = BLT or func = BGE or func = BLTU or func = BGEU 
      or func = ADDr or func = SUBr or func = SLLr or func = SLTr or func = SLTUr or func = XORr or func = SRLr or func = SRAr or func = ORr or func = ANDr;

--extra <= rfdb when s - type
--      <= immediate + pc when b -type
--      <= pc + 4 when jalr
--      <= pc when jal
extra <= rfdb when func = SB or func = SH or func = SW else
      Oinc when func = BEQ or func = BNE or func = BLT or func = BGE or func = BLTU or func = BGEU else
      Oinc2 when func = jalr else
      pcc when func = jal;
       
      

END ARCHITECTURE s;
