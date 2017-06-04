library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registers is
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
end Registers;

architecture Behavioral of Registers is

begin

N_NLproc:process(NR,NLR)
begin
    if(NR < NLR) then
        N_NL <= NR;
    else
        N_NL <= NLR;    
    end if;
end process;

N_NSproc:process(NR,NSR)
begin
    if(NR < NSR) then
        N_NS <= NR;
    else
        N_NS <= NSR;    
    end if;
end process; 

N_Zproc:process(NR,ZR)
begin
    if(NR < ZR) then
        N_Z <= NR;
    else
        N_Z <= ZR;    
    end if;
end process;

N_PSproc:process(NR,PSR)
begin
    if(NR < PSR) then
        N_PS <= NR;
    else
        N_PS <= PSR;    
    end if;
end process;

N_PLproc:process(NR,PLR)
begin
    if(NR < PLR) then
        N_PL <= NR;
    else
        N_PL <= PLR;    
    end if;
end process;

ZZ_NLproc:process(ZZR,NLR)
begin
    if(ZZR < NLR) then
        ZZ_NL <= ZZR;
    else
        ZZ_NL <= NLR;    
    end if;
end process;

ZZ_NSproc:process(ZZR,NSR)
begin
    if(ZZR < NSR) then
        ZZ_NS <= ZZR;
    else
        ZZ_NS <= NSR;    
    end if;
end process;

ZZ_Zproc:process(ZZR,ZR)
begin
    if(ZZR < ZR) then
        ZZ_Z <= ZZR;
    else
        ZZ_Z <= ZR;    
    end if;
end process;

ZZ_PSproc:process(ZZR,PSR)
begin
    if(ZZR < PSR) then
        ZZ_PS <= ZZR;
    else
        ZZ_PS <= PSR;    
    end if;
end process;

ZZ_PLproc:process(ZZR,PLR)
begin
    if(ZZR < PLR) then
        ZZ_PL <= ZZR;
    else
        ZZ_PL <= PLR;    
    end if;
end process;

P_NLproc:process(PR,NLR)
begin
    if(PR < NLR) then
        P_NL <= PR;
    else
        P_NL <= NLR;    
    end if;    
end process;

P_NSproc:process(PR,NSR)
begin
    if(PR < NSR) then
        P_NS <= PR;
    else
        P_NS <= NSR;    
    end if;
end process;

P_Zproc:process(PR,ZR)
begin
    if(PR < ZR) then
        P_Z <= PR;
    else
        P_Z <= ZR;    
    end if;
end process;

P_PSproc:process(PR,PSR)
begin
    if(PR < PSR) then
        P_PS <= PR;
    else
        P_PS <= PSR;    
    end if;
end process;

P_PLproc:process(PR,PLR)
begin
    if(PR < PLR) then
        P_PL <= PR;
    else
        P_PL <= PLR;    
    end if;
end process;

end Behavioral;
