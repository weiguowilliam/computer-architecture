--
-- VHDL Architecture my_project4_lib.mux5.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 22:00:11 03/17/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux5 IS
PORT( In0, In1, in2, in3 : IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Sel : IN std_ulogic_vector(1 downto 0));
END ENTITY mux5;

--
ARCHITECTURE b OF mux5 IS
BEGIN
PROCESS(In0, In1, in2, in3, Sel)
  BEGIN
    CASE Sel is
      WHEN "00" => Q <= In0;
      WHEN "01" => Q <= In1;
      when "10" => Q <= In2;
      when "11" => q <= In3;
      WHEN OTHERS => Q <= (others => 'X');
    END CASE;
  END PROCESS;
END ARCHITECTURE b;

