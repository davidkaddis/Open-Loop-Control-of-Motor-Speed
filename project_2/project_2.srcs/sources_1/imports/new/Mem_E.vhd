library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mem_E is
port( 
    E   : in unsigned(8 downto 0);
    DMNL: out unsigned(7 downto 0);
    DMNS: out unsigned(7 downto 0);
    DMZ : out unsigned(7 downto 0);
    DMPS: out unsigned(7 downto 0);
    DMPL: out unsigned(7 downto 0));
end Mem_E;

architecture Behavioral of Mem_E is

begin

Eproc:process(E)
begin
    if (E <= "001111101") then -- E <=125
        DMNL <= x"FF";
        DMNS <= x"00";
        DMZ  <= x"00";
        DMPS <= x"00";
        DMPL <= x"00";
    elsif ((E > "001111101") and (E < "010011101")) then -- 157 > E > 125 
        DMNL <= (x"09D" - E) sll 3;
        DMNS <= (E - x"07D") sll 3;
        DMZ  <= x"00";
        DMPS <= x"00";
        DMPL <= x"00";
    elsif ((E > "010011101") and (E < "011011111")) then -- 223 > E >  157
        DMNL <= x"00";
        DMNS <= x"FF";
        DMZ  <= x"00";
        DMPS <= x"00";
        DMPL <= x"00";
    elsif ((E > "011011111") and (E < "011111111")) then -- 223 > E >  255
        DMNL <= x"00";
        DMNS <= (x"0FF" - E) sll 3;
        DMZ  <= (E - x"0DF") sll 3;
        DMPS <= x"00";
        DMPL <= x"00";     
    elsif ((E > "011111111") and (E < "100011111")) then -- 255 > E >  287
        DMNL <= x"00";
        DMNS <= x"00";
        DMZ  <= (x"11F" - E) sll 3;
        DMPS <= (E - x"0FF") sll 3;
        DMPL <= x"00";     
    elsif ((E > x"100011111") and (E < "101100001")) then -- 287 > E >  353
        DMNL <= x"00";
        DMNS <= x"00";
        DMZ  <= x"00";
        DMPS <= x"FF";
        DMPL <= x"00";
    elsif ((E > "101100001") and (E < "110000001")) then -- 353 > E >  385
        DMNL <= x"00";
        DMNS <= x"00";
        DMZ  <= x"00";
        DMPS <= (x"181" - E) sll 3;
        DMPL <= (E - x"161") sll 3;
    else -- E >=  385 till 511
        DMNL <= x"00";
        DMNS <= x"00";
        DMZ  <= x"00";
        DMPS <= x"00";
        DMPL <= x"FF";
        end if;
end process;

end Behavioral;