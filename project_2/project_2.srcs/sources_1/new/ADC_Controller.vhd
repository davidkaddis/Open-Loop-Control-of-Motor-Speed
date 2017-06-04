library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADC_Controller is
  Port (clk, ready: in std_logic;
        add_in: out std_logic_vector(6 downto 0);
        data: in std_logic_vector(15 downto 0);
        v1,v2: out Std_logic_vector(11 downto 0) );
end ADC_Controller;

architecture Behavioral of ADC_Controller is
type state_type is (s0,s1);
signal state: state_type:=s0;
signal addin: std_logic_vector(6 downto 0);
signal v_1,v_2:  Std_logic_vector(11 downto 0 );
begin
process(clk)
begin
if(rising_edge(clk)) then
case state is
when s0=> if(ready='1') then v_1<=data(15 downto 4); addin<="0011011"; state<= s1; end if;
when s1=> if(ready='1') then v_2<=data(15 downto 4); addin<="0010011"; state<= s0; end if;
when others => state <= s0;
end case;
end if;
end process;

process(state)
begin
add_in<= addin;
if(state=s0) then  v1<=v_1;
elsif(state=s1) then  v2<=v_2;
end if;
end process;
end Behavioral;
