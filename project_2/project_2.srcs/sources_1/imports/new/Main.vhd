
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main is
 Port ( clk, ent:in std_logic;
        wadd:in std_logic_vector(2 downto 0);
        din:in std_logic_vector(5 downto 0);
        Ex: out std_logic_vector(7 downto 0);
        ca2cg: out std_logic_vector(6 downto 0);
        dp: out std_logic);
end Main;

architecture Behavioral of Main is
component debouncer is
    Port ( clk : in STD_LOGIC;
   ent : in STD_LOGIC;
   outw : out STD_LOGIC);
   end component;
   
  component DisplayInterface is
  Port (clk,w:in std_logic; wadd:in std_logic_vector(2 downto 0); din:in std_logic_vector(5 downto 0);
          En:out std_logic_vector(7 downto 0); ca2cg:out std_logic_vector(6 downto 0); dp: out std_logic);
  end component;

signal wx:std_logic;
begin
debouncer0: debouncer port map(clk,ent,wx);
DisplayInterface0: DisplayInterface port map(clk, wx, wadd, din, Ex, ca2cg, dp);

end Behavioral;
