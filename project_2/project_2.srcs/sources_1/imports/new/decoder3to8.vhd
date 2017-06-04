library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity decoder3to8 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
       En : out STD_LOGIC_VECTOR (7 downto 0));

end decoder3to8;

architecture Behavioral of decoder3to8 is
begin
process (I)
begin
      case I is
	  when "000" =>
        En <= "11111110";
      when "001" =>
        En <= "11111101";
      when "010" =>
        En <= "11111011";
      when "011" =>
        En <= "11110111";
       when "100" =>
          En <= "11101111";
        when "101" =>
          En <= "11011111";
        when "110" =>
          En <= "10111111";
        when "111" =>
          En <= "01111111";
	when others =>
		En <= "00000000";
     end case;
end process;


end Behavioral;
