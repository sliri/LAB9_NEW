-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 6.3.2022 18:44:42 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_up_down_counter is
    generic (CNT_WIDTH : integer := 4);
end tb_up_down_counter;

architecture tb of tb_up_down_counter is

    component up_down_counter
    generic (CNT_WIDTH : integer := 4);
        port (reset  : in std_logic;
              clk    : in std_logic;
              enable : in std_logic;
              updown : in std_logic;
              count  : out std_logic_vector (CNT_WIDTH-1 downto 0));
    end component;

    signal reset  : std_logic;
    signal clk    : std_logic;
    signal enable : std_logic;
    signal updown : std_logic;
    signal count  : std_logic_vector (CNT_WIDTH-1 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : up_down_counter
    port map (reset  => reset,
              clk    => clk,
              enable => enable,
              updown => updown,
              count  => count);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        enable <= '1';
        updown <= '1';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        wait for 70 ms;
        updown <= '0';




        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '0';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

