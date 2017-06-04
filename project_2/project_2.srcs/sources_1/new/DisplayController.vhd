
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DisplayController is
  Port (clk:in std_logic;
  DV13, DV12, DV11, DV10: in std_logic_vector(3 downto 0);
  DV23, DV22, DV21, DV20: in std_logic_vector(3 downto 0);
  w: out std_logic;
  wadd: out std_logic_vector(2 downto 0);
  din: out std_logic_vector(5 downto 0));
  
end DisplayController;

architecture Behavioral of DisplayController is
signal waddt: unsigned(2 downto 0);
signal wt: std_logic;
signal dint:std_logic_vector(5 downto 0);
type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8);
signal state: state_type:=s0;
begin
process
begin
if(rising_edge(clk)) then
case state is
when s0=>  waddt<="111"; dint<= ('1' & DV23 & '1'); state<=s1;
when s1=>  waddt<=waddt-"001"; dint<= '1' & DV22 & '1'; state<=s2;
when s2=>  waddt<=waddt-"001"; dint<= '1' & DV21 & '1'; state<=s3;
when s3=>  waddt<=waddt-"001"; dint<= '1' & DV20 & '1'; state<=s4;
when s4=>  waddt<=waddt-"001"; dint<= '1' & DV13 & '1'; state<=s5;
when s5=>  waddt<=waddt-"001"; dint<= '1' & DV12 & '1'; state<=s6;
when s6=>  waddt<=waddt-"001"; dint<= '1' & DV11 & '1'; state<=s7;
when s7=>  waddt<=waddt-"001"; dint<= '1' & DV10 & '1'; state<=s8;
when s8=>  state<=s0;
when others => state<=s0;
end case;
end if;
end process;
process(state)
begin
if(state /= s0) then wt <= '1'; else wt <= '0';
end if;
end process;
wadd<=std_logic_vector(waddt);
din<= dint;
w<=wt;
end Behavioral;
