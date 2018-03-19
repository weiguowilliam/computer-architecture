--
-- VHDL Architecture my_project4_lib.mux.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 20:23:10 02/11/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux IS
  PORT( In0 : IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Sel : IN std_ulogic);
END ENTITY mux;

--
ARCHITECTURE b OF mux IS
BEGIN
  PROCESS(In0, Sel)
  BEGIN
    CASE Sel is
      WHEN '0' => Q <= In0;
      WHEN OTHERS => Q <= (others=>'0');
    END CASE;
  END PROCESS;
END ARCHITECTURE b;

