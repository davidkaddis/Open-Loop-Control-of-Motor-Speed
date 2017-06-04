library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity binary2sevseg is
Port ( En:in std_logic; B : in STD_LOGIC_VECTOR (3 downto 0);
           sseg: out STD_LOGIC_VECTOR (6 downto 0));
end binary2sevseg;

architecture Behavioral of binary2sevseg is
type rom is array (0 to 15) of std_logic_vector(6 downto 0);
     
 constant ss_conv: rom :=( "0000001", "1001111", "0010010", "0000110", 
                           "1001100", "0100100", "0100000", "0001111", 
		                   "0000000", "0000100", "0001000", "1100000",
		                   "0110001", "1000010", "0110000", "0111000");              

begin
 sseg <= ss_conv(to_integer(unsigned(B)));

end Behavioral;
