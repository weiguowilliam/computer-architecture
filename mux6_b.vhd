--
-- VHDL Architecture my_project4_lib.mux6.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 22:12:22 03/17/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux6 IS
  port(in0, in1 : std_ulogic;
    q : out std_ulogic;
    sel : in std_ulogic := 'X');
END ENTITY mux6;

--
ARCHITECTURE b OF mux6 IS
BEGIN
  process(in0, in1, sel)
  begin 
    case sel is
    when '0' => q <= in0;
      when '1' => q <= in1;
        when others => q <= 'X';
          end case;
          end process;
END ARCHITECTURE b;

