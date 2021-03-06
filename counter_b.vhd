--
-- VHDL Architecture my_project4_lib.counter.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 20:37:00 02/11/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;
USE work.all;

ENTITY counter IS
  PORT( D : IN std_ulogic_vector(31 DOWNTO 0);
        Q : OUT std_ulogic_vector(31 DOWNTO 0);
        Clock, enable, reset : IN std_ulogic);
END ENTITY counter;

--
ARCHITECTURE b OF counter IS
  SIGNAL OReg : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL OInc : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL OMux : std_ulogic_vector(31 DOWNTO 0);
BEGIN
  Inc : ENTITY work.incrementor(b)
    PORT MAP(D => OReg, Q=> OInc, Inc => '0'&enable);
  Mux : ENTITY work.mux2(Behavior)
    PORT MAP(In0 => OInc, In1 =>D, Sel => reset, Q => OMux);
  Reg : ENTITY work.reg(b)
    PORT MAP(D => OMux, Q => OReg, Clock=>Clock, enable => '1', reset => '0');

Q <= OReg;  
END ARCHITECTURE b;

