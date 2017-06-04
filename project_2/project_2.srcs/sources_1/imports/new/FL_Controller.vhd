library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FL_Controller is
Port (
     clk : in std_logic;
     V1 : in std_logic_vector(7 downto 0);
     V2 : in std_logic_vector(7 downto 0);
     PW : out std_logic_vector(11 downto 0));
end FL_Controller;

architecture Behavioral of FL_Controller is

type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11);
signal state : state_type;

signal R : std_logic_vector(7 downto 0);
signal C : std_logic_vector(7 downto 0);
signal SC : unsigned(7 downto 0); 

--Mem E signals
signal E    : unsigned(8 downto 0);
signal DMNL : unsigned(7 downto 0);
signal DMNS : unsigned(7 downto 0);
signal DMZ  : unsigned(7 downto 0);
signal DMPS : unsigned(7 downto 0);
signal DMPL : unsigned(7 downto 0);

component Mem_E is
port( 
    E   : in unsigned(8 downto 0);
    DMNL: out unsigned(7 downto 0);
    DMNS: out unsigned(7 downto 0);
    DMZ : out unsigned(7 downto 0);
    DMPS: out unsigned(7 downto 0);
    DMPL: out unsigned(7 downto 0)
    );
end component;

--dE signals
signal dE : unsigned(9 downto 0);
signal DMN : unsigned(7 downto 0);
signal DMZZ : unsigned(7 downto 0);
signal DMP : unsigned(7 downto 0);

component Mem_dE is
Port (
    dE : in unsigned(9 downto 0);
    DMN : out unsigned(7 downto 0);
    DMZZ: out unsigned(7 downto 0);
    DMP : out unsigned(7 downto 0)
    );
end component;

--Outputs signal
signal N_NL : unsigned(7 downto 0);
signal N_NS : unsigned(7 downto 0);
signal N_Z  : unsigned(7 downto 0);
signal N_PS : unsigned(7 downto 0);
signal N_PL : unsigned(7 downto 0);
signal ZZ_NL : unsigned(7 downto 0);
signal ZZ_NS : unsigned(7 downto 0);
signal ZZ_Z : unsigned(7 downto 0);
signal ZZ_PS : unsigned(7 downto 0);
signal ZZ_PL : unsigned(7 downto 0);
signal P_NL : unsigned(7 downto 0);
signal P_NS : unsigned(7 downto 0);
signal P_Z : unsigned(7 downto 0);
signal P_PS : unsigned(7 downto 0);
signal P_PL : unsigned(7 downto 0);

signal NLOD : unsigned(7 downto 0);
signal NSOD : unsigned(7 downto 0);
signal ZOD  : unsigned(7 downto 0);
signal PSOD : unsigned(7 downto 0);
signal PLOD : unsigned(7 downto 0);

component Outputs is
Port (
      N_NL : in unsigned(7 downto 0);
      N_NS : in unsigned(7 downto 0);
      N_Z  : in unsigned(7 downto 0);
      N_PS : in unsigned(7 downto 0);
      N_PL : in unsigned(7 downto 0);
    
      ZZ_NL: in unsigned(7 downto 0);
      ZZ_NS: in unsigned(7 downto 0);
      ZZ_Z : in unsigned(7 downto 0);
      ZZ_PS: in unsigned(7 downto 0);
      ZZ_PL: in unsigned(7 downto 0);
    
      P_NL : in unsigned(7 downto 0);
      P_NS : in unsigned(7 downto 0);
      P_Z  : in unsigned(7 downto 0);
      P_PS : in unsigned(7 downto 0);
      P_PL : in unsigned(7 downto 0);
       
      NLOD : out unsigned(7 downto 0);
      NSOD : out unsigned(7 downto 0);
      ZOD  : out unsigned(7 downto 0);
      PSOD : out unsigned(7 downto 0);
      PLOD : out unsigned(7 downto 0)
      );
end component;

--Register signals
signal NR : unsigned(7 downto 0);
signal ZZR: unsigned(7 downto 0);
signal PR : unsigned(7 downto 0);
signal NLR: unsigned(7 downto 0);
signal NSR: unsigned(7 downto 0);
signal ZR: unsigned(7 downto 0);
signal PSR: unsigned(7 downto 0);
signal PLR: unsigned(7 downto 0);

component Registers is
Port (
    NR  : in unsigned(7 downto 0);
    ZZR : in unsigned(7 downto 0);
    PR : in unsigned(7 downto 0);
    
    NLR : in unsigned(7 downto 0);
    NSR : in unsigned(7 downto 0);
    ZR  : in unsigned(7 downto 0);
    PSR : in unsigned(7 downto 0);
    PLR : in unsigned(7 downto 0);
    
    N_NL: out unsigned(7 downto 0);
    N_NS: out unsigned(7 downto 0);
    N_Z : out unsigned(7 downto 0);
    N_PS : out unsigned(7 downto 0);
    N_PL : out unsigned(7 downto 0);
    
    ZZ_NL: out unsigned(7 downto 0);
    ZZ_NS: out unsigned(7 downto 0);
    ZZ_Z : out unsigned(7 downto 0);
    ZZ_PS: out unsigned(7 downto 0);
    ZZ_PL: out unsigned(7 downto 0);
    
    P_NL : out unsigned(7 downto 0);
    P_NS : out unsigned(7 downto 0);
    P_Z  : out unsigned(7 downto 0);
    P_PS : out unsigned(7 downto 0);
    P_PL : out unsigned(7 downto 0) 
    );
end component;

--registers holding previous values
signal N_NLR : unsigned(7 downto 0) := x"00";
signal N_NSR : unsigned(7 downto 0) := x"00";
signal N_ZR  : unsigned(7 downto 0) := x"00";
signal N_PSR : unsigned(7 downto 0) := x"00";
signal N_PLR : unsigned(7 downto 0) := x"00";
signal ZZ_NLR : unsigned(7 downto 0) := x"00";
signal ZZ_NSR : unsigned(7 downto 0) := x"00";
signal ZZ_ZR : unsigned(7 downto 0) := x"00";
signal ZZ_PSR : unsigned(7 downto 0) := x"00";
signal ZZ_PLR : unsigned(7 downto 0) := x"00";
signal P_NLR : unsigned(7 downto 0) := x"00";
signal P_NSR : unsigned(7 downto 0) := x"00";
signal P_ZR : unsigned(7 downto 0) := x"00";
signal P_PSR : unsigned(7 downto 0) := x"00";
signal P_PLR : unsigned(7 downto 0) := x"00";

signal ZOR : unsigned(7 downto 0) := x"00";
signal PSOR : unsigned(7 downto 0) := x"00";
signal NSOR : unsigned(7 downto 0) := x"00";
signal PLOR : unsigned(7 downto 0) := x"00";
signal NLOR : unsigned(7 downto 0) := x"00";

signal OE : unsigned(8 downto 0) := "000000000";

signal Den : unsigned (11 downto 0) := x"000";
signal Num : unsigned (11 downto 0) := x"000";

signal pwt : unsigned(11 downto 0);
signal PW_sig : unsigned(11 downto 0);

begin

PW <= std_logic_vector(PW_sig);

Error: Mem_E port map(
 E => E,
 DMNL => DMNL,
 DMNS => DMNS,
 DMZ => DMZ,
 DMPS => DMPS,
 DMPL => DMPL);

dError: Mem_dE port map(
 dE => dE,
 DMN => DMN,
 DMZZ => DMZZ,
 DMP => DMP);
 
Rule1: Registers port map
(
NR  => NR,
ZZR => ZZR,
PR  => PR,
    
NLR => NLR,
NSR => NSR,
ZR  => ZR,
PSR => PSR,
PLR => PLR,
    
N_NL => N_NL,
N_NS => N_NS,
N_Z  => N_Z,
N_PS => N_PS,
N_PL => N_PL,
    
ZZ_NL => ZZ_NL,
ZZ_NS => ZZ_NS,
ZZ_Z  => ZZ_Z,
ZZ_PS => ZZ_PS,
ZZ_PL => ZZ_PL,
    
P_NL => P_NL,
P_NS => P_NS,
P_Z  => P_Z,
P_PS => P_PS,
P_PL => P_PL
);

Rule2: Outputs port map
(
N_NL => N_NL,
N_NS => N_NS,
N_Z  => N_Z,
N_PS => N_PS,
N_PL => N_PL,
    
ZZ_NL => ZZ_NL,
ZZ_NS => ZZ_NS,
ZZ_Z  => ZZ_Z,
ZZ_PS => ZZ_PS,
ZZ_PL => ZZ_PL,
    
P_NL => P_NL,
P_NS => P_NS,
P_Z  => P_Z,
P_PS => P_PS,
P_PL => P_PL,
       
NLOD => NLOD,
NSOD => NSOD,
ZOD  => ZOD,
PSOD => PSOD,
PLOD => PLOD
);

F_controller_proc: process
begin
wait until (rising_edge(clk));
    case(state) is
        when s0 =>
                R <= V1;
                C <= V2;
                SC <= x"FF";
                state <= s1;
        when s1 =>
                E <= ("011111111" - unsigned(C) + unsigned(R));
                dE <=("0111111111" - OE + E);
                SC <= SC - 1;
                state <= s2;
        when s2 =>
                OE <= E;
                SC <= SC - 1;
                state <= s3;
        when s3 =>
                NLR <= DMNL;
                NSR <= DMNS;
                ZR <= DMZ;
                PSR <= DMPS;
                PLR <= DMPL;
                NR <= DMN;
                ZZR <= DMZZ;
                PR <= DMP;
                SC <= SC - 1;
                state <= s4;
        when s4 =>
                N_NLR <= N_NL;
                N_NSR <= N_NS;
                N_ZR <= N_Z;
                N_PSR <= N_PS;
                N_PLR <= N_PL;
                
                ZZ_NLR <= ZZ_NL;
                ZZ_NSR <= ZZ_NS;
                ZZ_ZR <= ZZ_Z;
                ZZ_PSR <= ZZ_PS;
                ZZ_PLR <= ZZ_PL;
                
                P_NLR <= P_NL;
                P_NSR <= P_NS;
                P_ZR <= P_Z;
                P_PSR <= P_PS;
                P_PLR <= P_PL;
                
                SC <= SC - 1;
                state <= s5;
        when s5 =>
                ZOR <= ZOD;
                PSOR <= PSOD;
                NSOR <= NSOD;
                PLOR <= PLOD;
                NLOR <= NLOD;
                SC <= SC - 1;
                state <= s6;
        when s6 =>
                Den <= to_unsigned(to_integer(NLOR + NSOR + ZOR + PSOR + PLOR),12);
                Num <= to_unsigned(to_integer(((NLOR(2 downto 0)&"00000") - (NLOR(5 downto 0)&"00")) + ((NSOR(2 downto 0)&"00000") - (NSOR(5 downto 0)&"00")) + (ZOR(2 downto 0) & "000000") + ((PSOR(2 downto 0)&"00000") - (PSOR(5 downto 0)&"00")) + ((PLOR(2 downto 0)&"00000") - (PLOR(5 downto 0)&"00"))),12);
                pwt <= x"000";
                state <= s7;
        when s7 =>
                SC <= SC - 1;
                    if (Num < Den) then
                        pwt <= pwt(0) & "00000000000";
                    else
                        pwt <= pwt + 1;
                        Num <= Num - Den;
                    end if;
                state <= s8;
        when s8 =>
                SC <= SC - 1;
                if (pwt < 4095) then
                    pwt <= 4095 - pwt;
                    state <= s9;
                else
                    pwt <= pwt - x"FFF";
                    state <= s10;
                end if;
        when s9 =>
                SC <= SC - 1;
                if (PW_sig > pwt) then
                    PW_sig <= PW_sig - pwt;
                    state <= s11;
                else
                    PW_sig <= x"000";
                    state <= s11;
                end if;
        when s10 =>
                SC <= SC - 1;
                if ((4095 - PW_sig) > pwt) then
                    PW_sig <= PW_sig + pwt;
                    state <= s11;
                else
                    PW_sig <= x"FFF";
                    state <= s11;
                end if; 
        when s11 =>
                SC <= SC - 1;
                if (SC = 0) then 
                    state <= s0;
                else 
                    SC <= SC - 1;
                    state <= s11;
                end if;
        when others =>
                state <= s0;
    end case;
end process;
end Behavioral;
