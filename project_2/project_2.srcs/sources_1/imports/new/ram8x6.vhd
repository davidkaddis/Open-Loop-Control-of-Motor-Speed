library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram8x6 is
  Port (w, clk:in std_logic; wadd:in std_logic_vector(2 downto 0); din:in std_logic_vector(5 downto 0); 
  radd: in std_logic_vector(2 downto 0); dout: out std_logic_vector(5 downto 0) );
end ram8x6;

architecture Behavioral of ram8x6 is

    type Memory is array(0 to 7) of unsigned(5 downto 0);
    signal RAM : Memory:=(others=>"000000");
    begin
      process
          begin 
            wait until (clk'event and clk='1');
             if (w='1') then RAM(to_integer(unsigned(wadd)))<= unsigned(din);
             end if;
       end process;
    dout<= std_logic_vector(RAM(to_integer(unsigned(radd))));
end Behavioral;