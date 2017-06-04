library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mem_dE is
Port (
    dE : in unsigned(9 downto 0);
    DMN : out unsigned(7 downto 0);
    DMZZ: out unsigned(7 downto 0);
    DMP : out unsigned(7 downto 0)
    );
end Mem_dE;

architecture Behavioral of Mem_dE is

begin

De_proc: process(dE)
begin
    if(dE <= "0110110100") then -- dE <= 436
        DMN  <= x"FF";
        DMZZ <= x"00";
        DMP  <= x"00";
    elsif((dE > "0110110100") and (dE < x"1F4")) then -- 436 < dE < 500 
        DMN  <= (x"1F4" - dE ) sll 2;
        DMZZ <= (dE - x"1B4") sll 2;
        DMP  <= x"00";
    elsif((dE > "0111110100") and (dE < "1000001100")) then -- 500 < dE < 524
        DMN  <= x"00";
        DMZZ <= x"FF";
        DMP  <= x"00";
    elsif((dE > "1000001100") and (dE < "1001001100")) then -- 524 < dE < 588
        DMN  <= x"00";
        DMZZ <= (x"24C" - dE) sll 2;
        DMP  <= (dE - x"20C") sll 2;
    else -- dE >= 588 till 1023
        DMN  <= x"00";
        DMZZ <= x"00";
        DMP  <= x"FF";   
    end if;
end process;
end Behavioral;
