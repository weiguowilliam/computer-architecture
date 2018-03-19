--
-- VHDL Architecture my_project4_lib.incrementor.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 20:42:04 02/11/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY incrementor IS
  PORT( D : IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Inc : IN std_ulogic_vector(1 DOWNTO 0));
END ENTITY incrementor;

--
ARCHITECTURE b OF incrementor IS
BEGIN
  PROCESS(D, Q, Inc)
    VARIABLE sum : UNSIGNED(31 DOWNTO 0);
  BEGIN
    CASE Inc is
      --WHEN "00" => sum := UNSIGNED(D)+0;
      WHEN "01" => sum := UNSIGNED(D)+4;
      --WHEN "10" => sum := UNSIGNED(D)+2;
      WHEN OTHERS => sum := UNSIGNED(D)+0;
    END CASE;
    Q <= std_ulogic_vector(SUM);
  END PROCESS;
END ARCHITECTURE b;

