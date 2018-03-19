--
-- VHDL Architecture my_project4_lib.tbdecoderp.b
--
-- Created:
--          by - Wei Guo.UNKNOWN (MSI)
--          at - 12:28:44 03/17/2018
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
--cannot connect to decoderp_s, no output
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE std.textio.all;
USE work.RV32I.all;

ENTITY tbdecoderp IS
  signal clock : std_ulogic;
END ENTITY tbdecoderp;

--
ARCHITECTURE b OF tbdecoderp IS
    --FILE test_vectors : text OPEN read_mode IS "testdecoderpipe.txt";
    FILE test_vectors : text OPEN read_mode IS "testdecoderpipe1.txt";
-- file "testdecoderpipe1" is for hybrid decoder
SIGNAL vecno : NATURAL := 0;
  --signal clock : std_ulogic;
  signal instruction, pc, rfda, rfdb :  std_ulogic_vector(31 downto 0);
  signal func, vfunc : RV32I_Op;
  signal rfaa, rfab, dest, vrfaa, vrfab, vdest  : std_ulogic_vector(4 downto 0); -- register id
  signal left, right, extra, vleft, vright, vextra : std_ulogic_vector(31 downto 0);
  
-- duv
BEGIN
duv: entity work.decoderp(s)
  port map(instruction => instruction, pc => pc, rfda => rfda, rfdb => rfdb, func => func, rfaa => rfaa, rfab => rfab, dest => dest, left => left, right => right, extra => extra);

-- stimulate process
    Stim: process
    variable L : line;
    variable FunName : Func_Name;
    variable instructionval : std_ulogic_vector(31 downto 0);
   -- variable funcval: RV32I_Op;
    variable pcval : std_ulogic_vector(31 downto 0);
    variable rfdaval, rfdbval :std_ulogic_vector(31 downto 0);
    variable rfaaval, rfabval, destval : std_ulogic_vector(4 downto 0);
    variable leftval, rightval, extraval : std_ulogic_vector(31 downto 0);

begin
    clock <= '0';
    wait for 50 ns;
    readline(test_vectors, L);

    while not endfile(test_vectors) loop
        readline(test_vectors, L);
--output
        read(L, FunName);
        vfunc <= Ftype(FunName);
        read(L,rfaaval);
        vrfaa <= rfaaval;
        read(L, rfabval);
        vrfab <= rfabval;
        read(L, destval);
        vdest <= destval;
        read(L, leftval);
        vleft <= leftval;
        read(L, rightval);
        vright <= rightval;
        read(L, extraval);
        vextra <= extraval;
--input
        read(L, instructionval);
        instruction <= instructionval;
        read(L, pcval);
        pc <= pcval;
        read(L, rfdaval);
        rfda <= rfdaval;
        read(L, rfdbval);
        rfdb <= rfdbval;

        Clock <= '1';
    wait for 50 ns;
    Clock <= '0';
  wait for 50 ns;
    end loop;

report "end of testbench";
std.env.finish;

    end process;

-- check process
check : process(clock)
begin
    if (falling_edge(clock)) then
        assert func = vfunc
        report "function type error";
        assert rfaa = vrfaa
        report "rfaa error";
        assert rfab = vrfab
        report "rfab error";
        assert dest = vdest
        report "dest error";
        assert left = vleft
        report "left error";
        assert right = vright
        report "right error";
        assert extra = vextra
        report "extra error";

        vecno <= vecno + 1;
    end if;
end process;


END ARCHITECTURE b;

