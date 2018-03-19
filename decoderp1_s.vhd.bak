--
-- VHDL Architecture my_project4_lib.decoderp1.s
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 21:14:30 03/17/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY decoderp1 IS
port(instruction, pc : in std_ulogic_vector(31 downto 0);
    rfda, rfdb : in std_ulogic_vector(31 downto 0);
    left, right, extra : OUT std_ulogic_vector(31 downto 0);
        rfaa, rfab, dest : OUT std_ulogic_vector(4 downto 0);
        func : OUT RV32I_Op
);
END ENTITY decoderp1;

--
ARCHITECTURE s OF decoderp1 IS
signal rs1v, rs2v, rdv : std_ulogic;
signal immediate, instr : std_ulogic_vector(31 downto 0);
--signal clock : std_ulogic;
signal pcsum, sum : std_ulogic_vector(31 downto 0);
signal leftc, extrac : std_ulogic_vector(1 downto 0);
signal rightc : std_ulogic;
signal rs1o, rs2o, rdo : std_ulogic_vector(4 downto 0);
signal immediateo : std_ulogic_vector(31 downto 0);
signal rs1vo, rs2vo, rdvo : std_ulogic;
signal funco : RV32I_Op;
--signal Oinc, Oinc2 : std_ulogic_vector(31 downto 0);

BEGIN
--dont use reg

decoder: entity work.decoder(b)
    port map(instruction=>instruction, func=>funco, rs1=>rs1o, rs2=>rs2o,rd=>rdo,rs1v=>rs1vo,rs2v=>rs2vo,rdv=>rdvo,immediate=>immediateo);

    func <= funco;
    rfaa <= rs1o;
    rfab <= rs2o;
    dest <= rdo;

    inc: entity work.inc(b)
    port map(d0 => instruction, d1 => pc, q => sum);
  
  inc2: entity work.inc(b)
    port map(d0 => pc, d1 =>"00000000000000000000000000000100", q => pcsum);

control : entity work.decodercontrol(b)
port map(func => func,  leftc => leftc, rightc => rightc, extrac => extrac);

muxleft: entity work.mux3(b)
port map(sel => leftc, in0 => pc, in1 => pcsum, in2 => rfda, q => left);

muxright : entity work.mux4(b)
port map(sel => rightc, in0=>immediateo, in1 => rfdb, q=>right);

muxextra : entity work.mux5(b)
port map(sel => extrac, in0 => immediateo, in1 => pcsum, in2 => sum, in3 => rfdb, q=> extra);

END ARCHITECTURE s;
