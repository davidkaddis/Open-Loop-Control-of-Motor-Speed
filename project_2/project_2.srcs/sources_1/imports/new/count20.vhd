----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2017 08:43:08 PM
-- Design Name: 
-- Module Name: count20 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity count20 is
    Port ( clk : in STD_LOGIC;
       count : out std_logic_vector(19 downto 0));
end count20;

architecture Behavioral of count20 is
signal count_int: unsigned(19 downto 0);
begin
     process(clk)
    begin
     if(clk'event and clk='1' ) then

       count_int <= count_int +1;

     end if;
end process;
  count <= std_logic_vector(count_int);

end Behavioral;
