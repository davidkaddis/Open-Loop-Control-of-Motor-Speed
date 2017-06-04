
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DisplayInterface is
Port (clk,w:in std_logic; wadd:in std_logic_vector(2 downto 0); din:in std_logic_vector(5 downto 0);
        En:out std_logic_vector(7 downto 0); ca2cg:out std_logic_vector(6 downto 0); dp: out std_logic);
end DisplayInterface;

architecture Behavioral of DisplayInterface is
component count20 is
    Port ( clk : in STD_LOGIC;
   count : out std_logic_vector(19 downto 0));
end component;

component decoder3to8 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
   En : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component ram8x6 is
  Port (w, clk:in std_logic; wadd:in std_logic_vector(2 downto 0); din:in std_logic_vector(5 downto 0); 
    radd: in std_logic_vector(2 downto 0); dout: out std_logic_vector(5 downto 0) );
end component;

component binary2sevseg is
Port (En:in std_logic; B : in STD_LOGIC_VECTOR (3 downto 0);
           sseg: out STD_LOGIC_VECTOR (6 downto 0));
end component;
signal count:std_logic_vector(19 downto 0);
signal dout:std_logic_vector(5 downto 0);

begin
count200:count20 Port map(clk, count);
decoder3to80: decoder3to8 Port map(count(19 downto 17), En);
ram8x60: ram8x6 Port map(w,clk,wadd,din,count(19 downto 17),dout);
binary2sevseg0: binary2sevseg Port map(dout(5), dout(4 downto 1), ca2cg);

dp<=dout(0);
end Behavioral;