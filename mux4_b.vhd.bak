--
-- VHDL Architecture my_project4_lib.mux4.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 21:58:09 03/17/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux4 IS
PORT( In0, In1: IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Sel : IN std_ulogic);

END ENTITY mux4;

--
ARCHITECTURE b OF mux4 IS
BEGIN
PROCESS(In0, In1, Sel)
  BEGIN
    CASE Sel is
      WHEN '0' => Q <= In0;
      WHEN '1' => Q <= In1;
WHEN OTHERS => Q <= (others => 'X');
    END CASE;
  END PROCESS;
END ARCHITECTURE b;

