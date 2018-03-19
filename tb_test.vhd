--
-- VHDL Architecture my_project4_lib.tb.test
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 21:10:14 02/15/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE std.textio.all;

ENTITY tb IS
END ENTITY tb;

--
ARCHITECTURE test OF tb IS
  
  FILE test_vectors : text OPEN read_mode IS "test.txt";
  
  SIGNAL Jaddr, Mdata : std_ulogic_vector(31 downto 0);
  SIGNAL Address, Addressv, Inst, Instv : std_ulogic_vector(31 downto 0);
  SIGNAL Clock, Jmp, Reset, Delay :  std_ulogic;
  SIGNAL Reade, Readev : std_ulogic;
  
  SIGNAL vecno : NATURAL := 0;
 
 
-- DUV Instantiation 
BEGIN
  
DUV : ENTITY work.fetch(structure)
  PORT MAP(Jaddr => Jaddr, Mdata => Mdata, Address => Address, Inst => Inst, Clock => Clock, Jmp => Jmp, Reset => Reset, Delay => Delay, Read => Reade);
    
-- Stimulus PRocess
  Stim : PROCESS
    VARIABLE L : LINE;
    VARIABLE Jaddrval, Mdataval : std_ulogic_vector(31 downto 0);
    VARIABLE Addressval,  Instval: std_ulogic_vector(31 downto 0);
    VARIaBLE Jmpval, Resetval, Delayval :  std_ulogic;
    VARIABLE Readval : std_ulogic;

BEGIN
  Clock <= '0';
  wait for 50 ns;
  readline(test_vectors, L);
  
WHILE NOT endfile(test_vectors) LOOP
  readline(test_vectors, L);  
  read(L, Jaddrval);
  Jaddr <= Jaddrval;
  read(L, Mdataval);
  Mdata <= Mdataval;
  read(L, Jmpval);
  Jmp <= Jmpval;
  read(L, Resetval);
  Reset <= Resetval;
  read(L, Delayval);
  Delay <= Delayval;
  read(L, Addressval);
  Addressv <= Addressval;
  read(L, Instval);
  Instv <= Instval;
  read(L, Readval);
  Readev <= Readval;
  
  --wait for 10 ns;
  Clock <= '1';
  wait for 50 ns;
  Clock <= '0';
  wait for 50 ns;
END LOOP;

report "End of Testbench";
std.env.finish;

END PROCESS;

--Checker Process
Check : PROCESS(Clock)
BEGIN
  IF (falling_edge(Clock)) THEN
    ASSERT Address = Addressv
      Report "Address error";
    ASSERT Inst = Instv
      Report "Inst error";
    ASSERT Reade = Readev
      Report "Read error";
    vecno <= vecno + 1;
  END IF;
END PROCESS;
  
END ARCHITECTURE test;
--END;
