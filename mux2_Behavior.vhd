--
-- VHDL Architecture my_project4_lib.mux2.Behavior
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 20:40:57 02/11/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux2 IS
  PORT( In0, In1 : IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Sel : IN std_ulogic);
END ENTITY mux2;

--
ARCHITECTURE Behavior OF mux2 IS
BEGIN
  PROCESS(In0, In1, Sel)
  BEGIN
    CASE Sel is
      WHEN '0' => Q <= In0;
      WHEN '1' => Q <= In1;
      WHEN OTHERS => Q <= (others=>'0');
    END CASE;
  END PROCESS;
END ARCHITECTURE Behavior;

