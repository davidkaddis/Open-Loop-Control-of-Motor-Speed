
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PWM is
  Port (PW: in std_logic_vector(11 downto 0); clk: in std_logic;
        PWM: out std_logic);
end PWM;

architecture Behavioral of PWM is
type statetype is (s0);
signal state: statetype;
signal IC: unsigned(11 downto 0):= "000000000000";
signal PC: unsigned(11 downto 0):= "000000000000";
signal pwmt: std_logic :='0';
begin
process
begin
wait until(RISING_EDGE(clk));
case state is 
    when s0=> 
    if (PW = "000000000000") then pwmt<='0'; state<= s0;
    else 
        if(PW="111111111111") then pwmt<='1'; state<=s0;
        else 
            if(IC="000000000000") then 
                if(PC < unsigned(PW)) then PC<=PC+1; IC<="000000000010";pwmt<='1'; state<=s0;
                else
                    PC<=PC+1; IC<="000000000010";pwmt<='0'; state<=s0; end if;
            else 
                IC<=IC-"000000000001"; state<=s0; end if;
            end if;
    end if;
when others => state <= s0;
end case;
end process;
PWM<=pwmt;
end Behavioral;
