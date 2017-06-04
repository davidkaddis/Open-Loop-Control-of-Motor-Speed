library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.All;

entity B2BCD is 
	Port(	clk: in std_logic;
		v1,v2: in std_logic_vector (11 downto 0);
		dv13,dv12,dv11,dv10: out std_logic_vector (3 downto 0);
		dv23,dv22,dv21,dv20: out std_logic_vector (3 downto 0)
		);
end 	B2BCD;

architecture Behavior of B2BCD IS
type state_type is (s0,s1,s2);
signal state: state_type:=s0;	
signal R: unsigned(11 downto 0);
signal d3t,d2t,d1t: unsigned (3 downto 0);
signal dv13t,dv12t,dv11t,dv10t,dv23t,dv22t,dv21t,dv20t : unsigned(3 downto 0);
begin
	process(clk'event)
	begin
		if (rising_edge(clk)) then
			case state is
			when s0=> R<= unsigned(v1); state<=s1;
			when s1=>	if (R>999) then
							D3t<=D3t+1;
							R<=R-1000;
						elsif ( R > 99) then
							D2t<=D2t+1;
							R<=R-100;
						elsif (R>9) then
							D1t<=D1t+1;
							R<=R-10;
						else dv10t<=R(3 downto 0);
						    dv11t <= d1t;
						    dv12t <= d2t;
						    dv13t <= d3t;
						    state<=s2;
						    d3t <= (others => '0');
						    d2t <= (others => '0');
						    d1t <= (others => '0'); 
						    R<=unsigned(v2);
						end if;
			when s2 =>	if (R>999) then
							D3t<=D3t+1;
							R<=R-1000;
						elsif (R>99) then
							D2t<=D2t+1;
							R<=R-100;
						elsif (R>9) then
							D1t<=D1t+1;
							R<=R-10;
						else dv20t<=R(3 downto 0); 
						     dv21t <= d1t;
                             dv22t <= d2t;
                             dv23t <= d3t;
                             d3t <= (others => '0');
                             d2t <= (others => '0');
                             d1t <= (others => '0');
						     state<=s1; R<= unsigned(v1);
						end if;
			end case;
		end if;
	end process;
dv23 <= std_logic_vector(dv23t);
dv22 <= std_logic_vector(dv22t);
dv21 <= std_logic_vector(dv21t);
dv20 <= std_logic_vector(dv20t);
dv13 <= std_logic_vector(dv13t);
dv12 <= std_logic_vector(dv12t);
dv11 <= std_logic_vector(dv11t);
dv10 <= std_logic_vector(dv10t);

end Behavior;

