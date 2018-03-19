--
-- VHDL Architecture my_project4_lib.inc.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 21:29:13 02/26/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY inc IS
  port(d0, d1: in std_ulogic_vector(31 downto 0);
    q : out std_ulogic_vector(31 downto 0));
END ENTITY inc;

--
ARCHITECTURE b OF inc IS
BEGIN
  process(d0, d1, q)
    variable sum : unsigned(31 downto 0);
    begin
      sum := unsigned(d0) + unsigned(d1);
      q <= std_ulogic_vector(sum);
  end process;
END ARCHITECTURE b;

