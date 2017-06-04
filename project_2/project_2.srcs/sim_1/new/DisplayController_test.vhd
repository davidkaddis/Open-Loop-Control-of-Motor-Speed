----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/23/2017 03:36:12 PM
-- Design Name: 
-- Module Name: DisplayController_test - Behavioral
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

entity DisplayController_test is
end DisplayController_test;

architecture Behavioral of DisplayController_test is
component DisplayController is
  Port (clk:in std_logic;
        DV13, DV12, DV11, DV10: in std_logic_vector(3 downto 0);
        DV23, DV22, DV21, DV20: in std_logic_vector(3 downto 0);
        w: out std_logic;
        wadd: out std_logic_vector(2 downto 0);
        din: out std_logic_vector(5 downto 0));
end component;
        signal clkt: std_logic;
       signal  DV13t, DV12t, DV11t, DV10t: std_logic_vector(3 downto 0);
       signal  DV23t, DV22t, DV21t, DV20t: std_logic_vector(3 downto 0);
       signal wt: std_logic;
       signal waddt: std_logic_vector(2 downto 0);
       signal dint: std_logic_vector(5 downto 0);
begin
uut: DisplayController Port map(clk=>clkt,DV13=>DV13t, DV12=>DV12t, DV11=>DV11t, DV10=>DV10t,DV23=>DV23t,DV22=> DV22t, DV21=> DV21t, DV20=>DV20t, w=>wt,wadd=>waddt,din=>dint);

clk_process: process
begin
    clkt<= '0'; wait for 1 ns;
    clkt<= '1'; wait for 1 ns;
end process;

sim_process: process
begin
DV13t<="0000";
DV12t<="0001";
DV11t<="0010";
DV10t<="0011";
DV23t<="0100";
DV22t<="0101";
DV21t<="0110";
DV20t<="0111"; wait for 4 ns;
DV13t<="1000";
DV12t<="1001";
DV11t<="1010";
DV10t<="1011";
DV23t<="1100";
DV22t<="1101";
DV21t<="1110";
DV20t<="1111"; wait for 4 ns;
end process;


end Behavioral;
