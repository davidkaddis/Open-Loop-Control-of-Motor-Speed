library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP is
  Port (clk:in std_logic;
        vauxp3, vauxn3, vauxp11, vauxn11:in std_logic;
         E_n: out std_logic_vector(7 downto 0);
         ca2cg: out std_logic_vector(6 downto 0);
         dp,pwmx: out std_logic);
end TOP;

architecture Behavioral of TOP is
component DisplayInterface is
Port (clk,w:in std_logic; 
        wadd:in std_logic_vector(2 downto 0); 
        din:in std_logic_vector(5 downto 0);
        En:out std_logic_vector(7 downto 0); 
        ca2cg:out std_logic_vector(6 downto 0); 
        dp: out std_logic);
end component;
component PWM is 
 Port (PW: in std_logic_vector(11 downto 0); clk: in std_logic;
       PWM: out std_logic);
 end component;

component DisplayController is
Port (clk:in std_logic;
  DV13, DV12, DV11, DV10: in std_logic_vector(3 downto 0);
  DV23, DV22, DV21, DV20: in std_logic_vector(3 downto 0);
  w: out std_logic;
  wadd: out std_logic_vector(2 downto 0);
  din: out std_logic_vector(5 downto 0));
end component;

component B2BCD is 
	Port(	clk: in std_logic;
    v1,v2: in std_logic_vector (11 downto 0);
    dv13,dv12,dv11,dv10: out std_logic_vector (3 downto 0);
    dv23,dv22,dv21,dv20: out std_logic_vector (3 downto 0)
    );
end component;

component ADC_Controller is 
  Port (clk, ready: in std_logic;
      add_in: out std_logic_vector(6 downto 0);
      data: in std_logic_vector(15 downto 0);
      v1,v2: out Std_logic_vector(11 downto 0) );
 end component;
 
component xadc_wiz_1 is
Port(   
 daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
 den_in          : in  STD_LOGIC ;                         -- Enable Signal for the dynamic reconfiguration port
 di_in           : in  STD_LOGIC_VECTOR (15 downto 0):= (others => '0');    -- Input data bus for the dynamic reconfiguration port
 dwe_in          : in  STD_LOGIC:= '0';                        -- Write Enable for the dynamic reconfiguration port
 do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
 drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
 dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
 reset_in        : in  STD_LOGIC := '0';                         -- Reset signal for the System Monitor control logic
 vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 3
 vauxn3          : in  STD_LOGIC;
 vauxp11         : in  STD_LOGIC;                         -- Auxiliary Channel 11
 vauxn11         : in  STD_LOGIC;
 busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
 channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
 eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
 eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
 alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
 vp_in           : in  STD_LOGIC:= '0';                         -- Dedicated Analog Input Pair
 vn_in           : in  STD_LOGIC:='0'
);
 end component;
signal Vone:std_logic_vector(11 downto 0);
signal Vtwo:std_logic_vector(11 downto 0);
signal pwmt:std_logic;
signal dv_13, dv_12,dv_11,dv_10, dv_23,dv_22, dv_21, dv_20:std_logic_vector(3 downto 0);
signal w_x, ready_x: std_logic;
signal w_add:std_logic_vector(2 downto 0);
signal d_in:std_logic_vector(5 downto 0);

signal addin: std_logic_vector(6 downto 0);
signal data_x : std_logic_vector(15 downto 0);
signal enable: std_logic;
begin
ADC_Controller0: ADC_Controller port map(clk, ready_x, addin, data_x, Vone, Vtwo);
xadc_wiz_10: xadc_wiz_1 port map(
addin, 	--Address bus for the dynamic reconfiguration port
enable,        --Enable Signal for the dynamic reconfiguration port
open,            --Input data bus for the dynamic reconfiguration port
open,            --Write Enable for the dynamic reconfiguration port
data_x,       --Output data bus for dynamic reconfiguration port  
ready_x,        --Data ready signal for the dynamic reconfiguration port 
clk,          --Clock input for the dynamic reconfiguration port  
open,            --Reset signal for the System Monitor control logic
vauxp3,       --Auxiliary Channel 3  
vauxn3,      -- 
vauxp11 ,      --Auxiliary Channel 11 
vauxn11 ,       
open ,               --ADC Busy signal
open ,              --Channel Selection Outputs
enable,        --End of Conversion Signal    
open,             --End of Sequence Signal
open ,           --OR'ed output of all the Alarms  
open,           --Dedicated Analog Input Pair      
open                   
 );

       


B2BCD0: B2BCD port map(clk, Vone, Vtwo, dv_13,dv_12,dv_11,dv_10,dv_23,dv_22,dv_21,dv_20);
DisplayController0: DisplayController port map(clk,dv_13,dv_12,dv_11,dv_10,dv_23,dv_22,dv_21,dv_20, w_x, w_add,d_in);
DisplayInterface0: DisplayInterface port map(clk,w_x,w_add,d_in, E_n, ca2cg, dp);
PWM0: PWM port map(Vtwo, clk, pwmt);
--to invert the output of octocoupler
pwmx<=not pwmt;
end Behavioral;
