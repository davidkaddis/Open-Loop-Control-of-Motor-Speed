library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Outputs is
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
end Outputs;

architecture Behavioral of Outputs is

signal NLODR : unsigned(7 downto 0) := x"00";
signal NSODR : unsigned(7 downto 0) := x"00";
signal ZODR  : unsigned(7 downto 0) := x"00";
signal PSODR : unsigned(7 downto 0) := x"00";
signal PLODR : unsigned(7 downto 0) := x"00";

begin

NLOD <= NLODR;
NSOD <= NSODR;
ZOD <= ZODR;
PSOD <= PSODR;
PLODR <= PLODR;

ZOD <= ZZ_Z;

N_PS_ZZ_PSproc:process(N_PS,ZZ_PS)
begin
    if(N_PS > ZZ_PS) then
        PSODR <= N_PS;
    else
        PSODR <= ZZ_PS;
    end if;
end process;

N_NL_ZZ_NLproc: process(N_NL,ZZ_NL,P_NL,N_NS)
begin
    if(N_NL > ZZ_NL) then
        NLODR <= N_NL;
    elsif(N_NL < ZZ_NL) then
        NLODR <= ZZ_NL;
    end if;
    
    if (NLODR > P_NL) then
        NLODR <= NLODR;
    elsif (NLODR < P_NL) then
        NLODR <= P_NL;
    end if;
    
    if(NLODR > N_NS) then
        NLODR <= NLODR;
    elsif(NLODR < N_NS) then
        NLODR <= N_NS;
    end if;
end process;

ZZ_NS_P_NSproc:process(ZZ_NS,P_NS)
begin
    if(ZZ_NS > P_NS) then
        NSODR <= ZZ_NS;
    else
        NSODR <= P_NS;
    end if;
end process;

P_PS_N_PL_ZZ_PL_P_PLproc: process(P_PS,N_PL,ZZ_PL,P_PL)
begin
    if(P_PS > N_PL) then
        PLODR <= P_PS;
    elsif (P_PS < N_PL) then
        PLODR <= N_PL;
    end if;
    if(PLODR > ZZ_PL) then
        PLODR <= PLODR;
    elsif (PLODR < ZZ_PL) then
        PLODR <= ZZ_PL;
    end if;
    if(PLODR > P_PL) then
        PLODR <= PLODR;
    elsif (PLODR < P_PL) then
        PLODR <= P_PL;
    end if;    
end process;

end Behavioral;
