--
-- VHDL Architecture my_project4_lib.fetch1.structure
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 21:40:26 02/11/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.all;

ENTITY fetch1 IS
  port ( Jaddr, Mdata : IN std_ulogic_vector(31 downto 0);
         Address, Inst : OUT std_ulogic_vector(31 downto 0);
         Clock, Jmp, Reset, Delay : IN std_ulogic;
         Read : OUT std_ulogic);
END ENTITY fetch1;

--
ARCHITECTURE structure OF fetch1 IS
  signal JR, DJR : std_ulogic;
  signal zer :std_ulogic_vector(31 downto 0):="00000000000000000000000000000000";
  signal NOP :std_ulogic_vector(31 downto 0):="00000000000000000000000000010011";
  signal OMux1 : std_ulogic_vector(31 downto 0);
  signal OCount : std_ulogic_vector(31 downto 0); 
  signal OMux2 : std_ulogic_vector(31 downto 0);

BEGIN

  Mux1: ENTITY work.mux2(Behavior)
    PORT MAP (In0=>Jaddr, In1=>zer,Sel=>Reset,Q=>OMux1);
  
  JR <= JMP or Reset;
  
  Counter: ENTITY work.counter(b)
    Port MAP (D=>OMux1, Clock=>Clock, enable=> not Delay, Reset=>JR, Q=>OCount);
  
  Address <= OCount;
  DJR <= JR or Delay;
  
  Mux2: ENTITY work.mux2(Behavior)
    PORT MAP (In0=>Mdata,In1=>NOP,Sel=>DJR,Q=>OMux2);
  
  Inst <= OMux2;
  Read <= not JR;
     
  


END ARCHITECTURE structure;

