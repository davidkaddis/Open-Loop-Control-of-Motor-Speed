library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_FL_Controller is
--  Port ( );
end tb_FL_Controller;

architecture Behavioral of tb_FL_Controller is

component FL_Controller is
Port (
     clk : in std_logic;
     V1 : in std_logic_vector(7 downto 0);
     V2 : in std_logic_vector(7 downto 0);
     PW : out std_logic_vector(11 downto 0)
     );
end component;

signal clk : std_logic := '0';
signal V1  : std_logic_vector(7 downto 0) := "00000000";
signal V2  : std_logic_vector(7 downto 0) := "00000000";
signal PW  : std_logic_vector(11 downto 0);

begin

uut: FL_Controller port map
(
    clk => clk,
    V1 => V1,
    V2 => V2,
    PW => PW
);

clk_proc: process
begin
clk <= '1';
wait for 0.5 ns;
clk <= '0';
wait for 0.5 ns;
end process;

stimuliproc: process
begin
V1 <= x"44"; V2 <= x"44"; 
wait for 600 ns;
end process;

end Behavioral;
