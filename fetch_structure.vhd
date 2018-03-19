--
-- VHDL Architecture my_project4_lib.fetch.structure
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 18:19:36 02/11/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY fetch IS
  port ( Jaddr, Mdata : IN std_ulogic_vector(31 downto 0);
         Address, Inst : OUT std_ulogic_vector(31 downto 0);
         Clock, Jmp, Reset, Delay : IN std_ulogic;
         Read : OUT std_ulogic);
END ENTITY fetch;

--architecture body declaration
ARCHITECTURE structure OF fetch IS 
  --signal NOP : std_ulogic_vector(31 downto 0):= "00000000000000000000000000010011";
  --signal JR, DJR : std_ulogic;
BEGIN
  PROCESS (Clock)
    VARIABLE InV, OutV : UNSIGNED(31 DOWNTO 0);
  BEGIN
    IF(Reset = '1') THEN
      InV := "00000000000000000000000000000000";
    ELSIF(Jmp = '1') THEN
      InV := UNSIGNED(Jaddr);
    ELSIF((Reset = '0') AND (Jmp = '0')) THEN
      InV := OutV + 4;
    END IF;
    
    IF(rising_edge(Clock)) THEN
      IF(Delay = '0') THEN
        OutV := InV;
      END IF;
    END IF;
    
    Address <= std_ulogic_vector(OutV);
  END PROCESS;
  
  PROCESS (Reset, Jmp, Delay)
  BEGIN
    --JR <= Jmp or Reset;
    --DJR <= JR or Delay;
    if(Reset or Jmp or Delay) then
      Inst <= "00000000000000000000000000010011";
    ELSE
      Inst <= Mdata;
    END IF;
  END PROCESS;
  
  --Read <= NOT(Reset OR Jmp OR Delay);
    Read <= NOT(Reset OR Jmp);
    
END ARCHITECTURE structure;

