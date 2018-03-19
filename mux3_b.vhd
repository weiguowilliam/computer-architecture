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

ENTITY mux3 IS
  PORT( In0, In1, in2 : IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Sel : IN std_ulogic_vector(1 downto 0));
END ENTITY mux3;

--
ARCHITECTURE b OF mux3 IS
BEGIN
  PROCESS(In0, In1, in2, Sel)
  BEGIN
    CASE Sel is
      WHEN "00" => Q <= In0;
      WHEN "01" => Q <= In1;
      when "10" => Q <= In2;
      WHEN OTHERS => Q <= (others => 'X');
    END CASE;
  END PROCESS;
END ARCHITECTURE b;

