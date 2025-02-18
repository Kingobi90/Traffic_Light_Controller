library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity traffic_light_controller is
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
end traffic_light_controller;

architecture traffic_light of traffic_light_controller is
   
	type FSM_States is (HGRE_FRED, HYEL_FRED, HRED_FGRE, HRED_FYEL, PED_WALK, PED_BLINK, PED_STOP, WAIT_FOR_VEHICLE, EMERGENCY_OVERRIDE);
	signal current_state, next_state: FSM_States;

	signal veh_highway_countdown : std_logic_vector(3 downto 0) := "1010";
	signal veh_farm_countdown	: std_logic_vector(3 downto 0) := "1010";
	signal ped_countdown     	: std_logic_vector(3 downto 0) := "0100";

begin
    
	process(clk, rst_n)
	begin
    	if rst_n = '0' then
        	current_state <= HGRE_FRED;
        	veh_highway_countdown <= "1010";
        	veh_farm_countdown <= "1010";
        	ped_countdown <= "0100";
    	elsif rising_edge(clk) then
        	current_state <= next_state;

        	if current_state /= next_state then
            	case next_state is
                	when HGRE_FRED =>
                    	veh_highway_countdown <= "1010";
                    	veh_farm_countdown <= "1010";
                    	ped_countdown <= "0100";
                	when PED_WALK =>
                    	ped_countdown <= "0100";  
                	when HRED_FGRE =>
                    	veh_farm_countdown <= "1010";  
                	when others =>
            	end case;
        	end if;

        	if current_state = HGRE_FRED and veh_highway_countdown > "0000" then
            	veh_highway_countdown <= veh_highway_countdown - 1;
        	end if;
        	if (current_state = HRED_FGRE or current_state = WAIT_FOR_VEHICLE) and veh_farm_countdown > "0000" then
            	veh_farm_countdown <= veh_farm_countdown - 1;
        	end if;
        	if (current_state = PED_WALK or current_state = PED_BLINK) and ped_countdown > "0000" then
            	ped_countdown <= ped_countdown - 1;
        	end if;
    	end if;
	end process;

	process(current_state, sensor, ped_btn, emergency_signal)
	begin
    	case current_state is
        	when HGRE_FRED =>
            	light_highway <= "001";
            	light_farm <= "100";
            	light_ped <= "10";

            	if emergency_signal = '1' then
                	next_state <= EMERGENCY_OVERRIDE;
            	elsif ped_btn = '1' then
                	next_state <= PED_WALK;
            	elsif sensor = '1' then
                	next_state <= WAIT_FOR_VEHICLE;
            	else
                	next_state <= HGRE_FRED;
            	end if;

        	when WAIT_FOR_VEHICLE =>
            	if sensor = '1' then
                	next_state <= HYEL_FRED;
            	else
                	next_state <= HGRE_FRED;
            	end if;

        	when others =>
            	next_state <= HGRE_FRED;
    	end case;
	end process;

	countdown_veh_highway <= veh_highway_countdown;
	countdown_veh_farm <= veh_farm_countdown;
	countdown_ped <= ped_countdown;

end traffic_light;
