--
-- VHDL Architecture my_project4_lib.tbalu.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 23:02:21 03/22/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE std.textio.all;
USE work.RV32I.all;

--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use ieee.NUMERIC_STD.all;

ENTITY tbalu IS
  signal clock : std_ulogic;
END ENTITY tbalu;

--
ARCHITECTURE b OF tbalu IS

FILE test_vectors : text OPEN read_mode IS "testalu.txt";

SIGNAL vecno : NATURAL := 0;
SIGNAL in_a, in_b : std_ulogic_vector(31 downto 0);
SIGNAL sel:  ALU_Op;
SIGNAL q, vq :  std_ulogic_vector(31 downto 0);
SIGNAL flagq, vflagq: std_ulogic;

--duv
begin
DUV: entity work.alu(b)
port map(in_a => in_a, in_b => in_b, sel => sel, q => q, flagq => flagq);
  
--stimulate process
Stim: process
  VARIABLE L : LINE;
  --variable ALUName : ALU_Name;
  variable in_aval, in_bval :  std_ulogic_vector(31 downto 0);
  variable selval : ALU_Name;
  variable qval : std_ulogic_vector(31 downto 0);
  variable flagqval : std_ulogic;

begin
Clock <= '0';
  wait for 50 ns;
  readline(test_vectors, L);
  
  while not endfile(test_vectors) loop
    readline(test_vectors, L);
    
    read(L, selval);
    sel <= Atype(selval);
    
    --input
    read(L, in_aval);
    in_a <= in_aval;
    read(L, in_bval);
    in_b <= in_bval;
    
    --output
    read(L, qval);
    vq <= qval;
    read(L, flagqval);
    vflagq <= flagqval; 
    
    
    
 
    
    ----input
--    read(L, in_aval);
--    in_a <= in_aval;
--    read(L, in_bval);
--    in_b <= in_bval;
--    
--    
--    
--    read(L, selval);
--    sel <= Atype(selval);
--    
--    --output
--    read(L, qval);
--    vq <= qval;
--    read(L, flagqval);
--    vflagq <= flagqval; 
          
    
  Clock <= '1';
  wait for 50 ns;
  Clock <= '0';
  wait for 50 ns;
    
    --wait for 100 ns;
  end loop;

report "End of Testbench";
std.env.finish;

end process;

--check process

Check : PROCESS(clock)
BEGIN
  IF (falling_edge(clock)) THEN
    ASSERT q = vq
      Report "output q error";
    ASSERT flagq = vflagq
      Report "flag for 0 error";
  
    vecno <= vecno + 1;
  END IF;
END PROCESS;

END ARCHITECTURE b;

