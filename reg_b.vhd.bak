--
-- VHDL Architecture my_project4_lib.reg.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 20:48:29 02/11/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY reg IS
  PORT( D : IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Clock, reset, enable : IN std_ulogic);
END ENTITY reg;

--
ARCHITECTURE b OF reg IS
BEGIN
  PROCESS(Clock, reset)
  BEGIN
    IF reset = '1' then
      Q <= (others=>'0');
    else
      if (rising_edge(Clock)) and enable = '1' then
        Q <= D;
      end if;
    end if;
  END PROCESS;
END ARCHITECTURE b;

