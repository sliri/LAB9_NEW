----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2022 08:35:07 AM
-- Design Name: 
-- Module Name: up_down_counter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up_down_counter is
    generic (CNT_WIDTH : integer := 4);
    Port ( reset        : in STD_LOGIC; 
           clk          : in STD_LOGIC; --100 MHz clock
           enable       : in STD_LOGIC;
           updown       : in STD_LOGIC; --UP IS 'HIGH'
           count        : out STD_LOGIC_VECTOR (CNT_WIDTH-1 downto 0));
end up_down_counter;



architecture Behavioral of up_down_counter is

    constant C_HALF_SEC_COUNTS  :integer:= 100; ---5MHz counts in one second...
    constant C_UP               :std_logic:='1';
    constant C_DOWN             :std_logic:='0';
    SUBTYPE one_sec_cntr_type    is integer range 0 to 100; 


--signals declerations
------------------------------------------
   signal  reset_sig        :     std_logic;    
   signal  clk_sig          :     std_logic;
   signal  enable_sig       :     std_logic;
   signal  updown_sig       :     std_logic;
   signal  count_sig        :     std_logic_vector(CNT_WIDTH-1 downto 0);
   signal  onesec_clock     :     std_logic;
   signal  clk_5mhz_sig     :     std_logic;   
   signal  one_sec_cntr     :     one_sec_cntr_type;


--component declerations
------------------------------------------
   component clk_wiz_0 is
    port ( 
      clk_out1  : out std_logic;
      reset     : in std_logic;
      clk_in1   : in std_logic
    );
   end component clk_wiz_0; 
   

begin
    --dataflow statements
------------------------------------------
    reset_sig    <=   reset;   
    clk_sig      <=   clk;     
    enable_sig   <=   enable;  
    updown_sig   <=   updown;  
    count        <=   count_sig;
                

   --instantiations
-- -----------------------------------------
    clk_wiz_0_comp:  clk_wiz_0 
        Port map( 
          clk_out1  => clk_5mhz_sig,
          reset     => reset_sig,
          clk_in1   => clk_sig
        );
     

  --process statements

  --generating one second period clock 50%
  -- from the 5MHz
----------------------------------------
clock_devide_proc :process (reset_sig,clk_5mhz_sig)
begin
    if reset_sig = '1' then
        onesec_clock <= '0';
        one_sec_cntr <= 0;
    elsif rising_edge(clk_5mhz_sig) then
        if one_sec_cntr = C_HALF_SEC_COUNTS-1 then
            onesec_clock <= not(onesec_clock); 
            one_sec_cntr <= 0;
        else
            one_sec_cntr <= one_sec_cntr+1;
        end if;
    end if;
end process clock_devide_proc;
            

counter_proc :process(reset_sig,onesec_clock)
begin
    if reset_sig = '1' then
        count_sig <=  std_logic_vector(to_unsinged((0, count_sig'length));
    elsif rising_edge(onesec_clock) then
        if enable_sig = '1' then
            case updown_sig is
                when C_UP =>
                    count_sig <= count_sig+'1';
                when C_DOWN =>
                    count_sig <= count_sig-'1';
                when others =>
                 null;
            end case; 
        end if;
    end if;
end process counter_proc;





end Behavioral;
