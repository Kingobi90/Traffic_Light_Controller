library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity traffic_light_tb is
end traffic_light_tb;

architecture behavior of traffic_light_tb is

	component traffic_light_controller
    	port (
        	sensor           	: in STD_LOGIC;
        	ped_btn          	: in STD_LOGIC;
        	emergency_signal 	: in STD_LOGIC;
        	clk             	: in STD_LOGIC;
        	rst_n           	: in STD_LOGIC;
        	light_highway   	: out STD_LOGIC_VECTOR(2 downto 0);
        	light_farm      	: out STD_LOGIC_VECTOR(2 downto 0);
        	light_ped       	: out STD_LOGIC_VECTOR(1 downto 0);
        	countdown_veh_highway : out STD_LOGIC_VECTOR(3 downto 0);
        	countdown_veh_farm   : out STD_LOGIC_VECTOR(3 downto 0);
        	countdown_ped    	: out STD_LOGIC_VECTOR(3 downto 0)
    	);
	end component;

	signal sensor_tb     	: STD_LOGIC := '0';
	signal ped_btn_tb    	: STD_LOGIC := '0';
	signal emergency_signal_tb : STD_LOGIC := '0';
	signal clk_tb        	: STD_LOGIC := '0';
	signal rst_n_tb      	: STD_LOGIC := '0';

	signal light_highway_tb  : STD_LOGIC_VECTOR(2 downto 0);
	signal light_farm_tb 	: STD_LOGIC_VECTOR(2 downto 0);
	signal light_ped_tb  	: STD_LOGIC_VECTOR(1 downto 0);
	signal countdown_veh_highway_tb : STD_LOGIC_VECTOR(3 downto 0);
	signal countdown_veh_farm_tb	: STD_LOGIC_VECTOR(3 downto 0);
	signal countdown_ped_tb     	: STD_LOGIC_VECTOR(3 downto 0);

	constant CLK_PERIOD : time := 10 ns;

begin

	uut: traffic_light_controller
    	port map (
        	sensor           	=> sensor_tb,
        	ped_btn          	=> ped_btn_tb,
        	emergency_signal 	=> emergency_signal_tb,
        	clk             	=> clk_tb,
        	rst_n           	=> rst_n_tb,
        	light_highway   	=> light_highway_tb,
        	light_farm      	=> light_farm_tb,
        	light_ped       	=> light_ped_tb,
        	countdown_veh_highway => countdown_veh_highway_tb,
        	countdown_veh_farm   => countdown_veh_farm_tb,
        	countdown_ped    	=> countdown_ped_tb
    	);

	clk_process : process
	begin
    	while true loop
        	clk_tb <= '0';
        	wait for CLK_PERIOD / 2;
        	clk_tb <= '1';
        	wait for CLK_PERIOD / 2;
    	end loop;
	end process;

	stim_process : process
	begin
    	rst_n_tb <= '0';
    	wait for 50 ns;
    	rst_n_tb <= '1';
    	wait for 50 ns;

    	sensor_tb <= '0';
    	ped_btn_tb <= '0';
    	emergency_signal_tb <= '0';
    	wait for 100 ns;

    	wait for 100 ns;

    	sensor_tb <= '1';
    	wait for 100 ns;
    	sensor_tb <= '0';
    	wait for 100 ns;

    	ped_btn_tb <= '1';
    	wait for 50 ns;
    	ped_btn_tb <= '0';
    	wait for 100 ns;

    	emergency_signal_tb <= '1';
    	wait for 50 ns;
    	emergency_signal_tb <= '0';
    	wait for 100 ns;

    	sensor_tb <= '1';
    	ped_btn_tb <= '1';
    	wait for 100 ns;
    	sensor_tb <= '0';
    	ped_btn_tb <= '0';
    	wait for 100 ns;

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

    	sensor_tb <= '1';
    	wait for 100 ns;
    	sensor_tb <= '0';
    	wait for 100 ns;
    	ped_btn_tb <= '1';
    	wait for 50 ns;
    	ped_btn_tb <= '0';
    	wait for 100 ns;
    	emergency_signal_tb <= '1';
    	wait for 50 ns;
    	emergency_signal_tb <= '0';
    	wait for 100 ns;

    	sensor_tb <= '0';
    	ped_btn_tb <= '0';
    	emergency_signal_tb <= '0';
    	wait for 200 ns;

    	sensor_tb <= '1';
    	emergency_signal_tb <= '1';
    	wait for 100 ns;
    	emergency_signal_tb <= '0';
    	wait for 100 ns;

    	emergency_signal_tb <= '1';
    	ped_btn_tb <= '1';
    	wait for 100 ns;
    	ped_btn_tb <= '0';
    	emergency_signal_tb <= '0';
    	wait for 100 ns;

    	ped_btn_tb <= '1';
    	wait for 50 ns;
    	ped_btn_tb <= '0';
    	wait for 50 ns;
    	ped_btn_tb <= '1';
    	wait for 50 ns;
    	ped_btn_tb <= '0';
    	wait for 100 ns;

    	rst_n_tb <= '0';
    	wait for 50 ns;
    	rst_n_tb <= '1';
    	wait for 50 ns;
    	emergency_signal_tb <= '1';
    	wait for 100 ns;
    	emergency_signal_tb <= '0';
    	wait for 100 ns;

    	sensor_tb <= '0';
    	wait for 500 ns;

    	wait;
	end process;

end behavior;

