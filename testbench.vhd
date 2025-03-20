library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use NUMERIC_STD for proper arithmetic operations

entity traffic_light_tb is
end traffic_light_tb;

architecture behavior of traffic_light_tb is

    component traffic_light_controller
        port (
            sensor              : in STD_LOGIC;
            ped_btn             : in STD_LOGIC;
            emergency_signal    : in STD_LOGIC;
            clk                 : in STD_LOGIC;
            rst_n               : in STD_LOGIC;
            light_highway       : out STD_LOGIC_VECTOR(2 downto 0);
            light_farm          : out STD_LOGIC_VECTOR(2 downto 0);
            light_ped           : out STD_LOGIC_VECTOR(1 downto 0);
            countdown_veh_highway : out STD_LOGIC_VECTOR(3 downto 0);
            countdown_veh_farm   : out STD_LOGIC_VECTOR(3 downto 0);
            countdown_ped       : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Signals
    signal sensor_tb        : STD_LOGIC := '0';
    signal ped_btn_tb       : STD_LOGIC := '0';
    signal emergency_signal_tb : STD_LOGIC := '0';
    signal clk_tb           : STD_LOGIC := '0';
    signal rst_n_tb         : STD_LOGIC := '0';

    signal light_highway_tb : STD_LOGIC_VECTOR(2 downto 0);
    signal light_farm_tb    : STD_LOGIC_VECTOR(2 downto 0);
    signal light_ped_tb     : STD_LOGIC_VECTOR(1 downto 0);
    signal countdown_veh_highway_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal countdown_veh_farm_tb    : STD_LOGIC_VECTOR(3 downto 0);
    signal countdown_ped_tb         : STD_LOGIC_VECTOR(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: traffic_light_controller
        port map (
            sensor              => sensor_tb,
            ped_btn             => ped_btn_tb,
            emergency_signal    => emergency_signal_tb,
            clk                 => clk_tb,
            rst_n               => rst_n_tb,
            light_highway       => light_highway_tb,
            light_farm          => light_farm_tb,
            light_ped           => light_ped_tb,
            countdown_veh_highway => countdown_veh_highway_tb,
            countdown_veh_farm   => countdown_veh_farm_tb,
            countdown_ped       => countdown_ped_tb
        );

    -- Clock Process
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus Process
    stim_process : process
    begin
        -- Reset system
        report "Applying Reset...";
        rst_n_tb <= '0';
        wait for 50 ns;
        rst_n_tb <= '1';
        report "Reset Released...";
        wait for 100 ns;

        -- Initial Conditions
        sensor_tb <= '0';
        ped_btn_tb <= '0';
        emergency_signal_tb <= '0';
        wait for 200 ns;

        -- Test 1: Vehicle detected at farm road
        report "Test 1: Vehicle detected at farm road";
        sensor_tb <= '1';
        wait for 300 ns;
        sensor_tb <= '0';
        wait for 200 ns;

        -- Test 2: Pedestrian button pressed
        report "Test 2: Pedestrian button pressed";
        ped_btn_tb <= '1';
        wait for 100 ns;
        ped_btn_tb <= '0';
        wait for 400 ns;

        -- Test 3: Emergency mode activation
        report "Test 3: Emergency Mode Activated";
        emergency_signal_tb <= '1';
        wait for 150 ns;
        emergency_signal_tb <= '0';
        wait for 300 ns;

        -- Test 4: Combined event (Sensor & Pedestrian Press)
        report "Test 4: Vehicle detected & Pedestrian button pressed";
        sensor_tb <= '1';
        ped_btn_tb <= '1';
        wait for 200 ns;
        sensor_tb <= '0';
        ped_btn_tb <= '0';
        wait for 300 ns;

        -- Test 5: Random toggles of signals
        report "Test 5: Random toggles";
        sensor_tb <= '1';
        wait for 100 ns;
        sensor_tb <= '0';
        wait for 100 ns;
        ped_btn_tb <= '1';
        wait for 100 ns;
        ped_btn_tb <= '0';
        wait for 100 ns;
        emergency_signal_tb <= '1';
        wait for 100 ns;
        emergency_signal_tb <= '0';
        wait for 100 ns;

        -- Reset the system again
        report "Final Reset...";
        rst_n_tb <= '0';
        wait for 50 ns;
        rst_n_tb <= '1';
        wait for 200 ns;

        -- End of simulation
        report "Simulation Completed.";
        wait;
    end process;

end behavior;
