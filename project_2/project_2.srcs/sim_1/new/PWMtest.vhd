
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PWMtest is
end PWMtest;

architecture Behavioral of PWMtest is
component PWM is 
  Port (PW: in std_logic_vector(11 downto 0); clk: in std_logic;
      PWM: out std_logic);
end component;

signal clkt: std_logic;
signal PWt: std_logic_vector(11 downto 0);
signal PWMt: std_logic;
begin
uut: PWM port map(clk=>clkt, PW=>PWt, PWM=>PWMt);

clk: process
begin
    clkt<= '0'; wait for 1 ns;
    clkt<= '1'; wait for 1 ns;
end process;

sim: process
begin
PWt<="000000000001"; wait for 150ns;
PWt<="100000000000";wait for 150ns;
PWt<="111111111111";
wait;

end process;
end Behavioral;
