library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use NUMERIC_STD for proper arithmetic operations

entity traffic_light_controller is
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
end traffic_light_controller;

architecture traffic_light of traffic_light_controller is

    type FSM_States is (HGRE_FRED, HYEL_FRED, HRED_FGRE, HRED_FYEL, PED_WALK, PED_BLINK, PED_STOP, WAIT_FOR_VEHICLE, EMERGENCY_OVERRIDE);
    signal current_state, next_state: FSM_States;

    signal veh_highway_countdown : unsigned(3 downto 0) := "1010";  -- 10 sec for highway
    signal veh_farm_countdown    : unsigned(3 downto 0) := "1010";  -- 10 sec for farm road
    signal ped_countdown         : unsigned(3 downto 0) := "0100";  -- 4 sec for pedestrian crossing

begin

    -- Synchronous State Transition & Countdown Update
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            -- Reset everything
            current_state <= HGRE_FRED;
            veh_highway_countdown <= "1010";
            veh_farm_countdown <= "1010";
            ped_countdown <= "0100";
        elsif rising_edge(clk) then
            current_state <= next_state;

            -- Reset countdowns only **when entering a new state**
            if current_state /= next_state then
                case next_state is
                    when HGRE_FRED =>
                        veh_highway_countdown <= "1010";
                    when HRED_FGRE =>
                        veh_farm_countdown <= "1010";
                    when PED_WALK =>
                        ped_countdown <= "0100";
                    when others =>
                end case;
            end if;

            -- **Only decrement countdown if it’s not already 0000**
            if veh_highway_countdown > "0000" and current_state = HGRE_FRED then
                veh_highway_countdown <= veh_highway_countdown - 1;
            end if;

            if veh_farm_countdown > "0000" and current_state = HRED_FGRE then
                veh_farm_countdown <= veh_farm_countdown - 1;
            end if;

            if ped_countdown > "0000" and (current_state = PED_WALK or current_state = PED_BLINK) then
                ped_countdown <= ped_countdown - 1;
            end if;
        end if;
    end process;

    -- FSM State Transitions
    process(current_state, sensor, ped_btn, emergency_signal)
    begin
        case current_state is
            when HGRE_FRED =>
                light_highway <= "001";  -- Green Highway
                light_farm <= "100";     -- Red Farm
                light_ped <= "00";       -- Don't Walk

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

            when HYEL_FRED =>
                light_highway <= "010";  -- Yellow Highway
                light_farm <= "100";     -- Red Farm
                light_ped <= "00";

                next_state <= HRED_FGRE;

            when HRED_FGRE =>
                light_highway <= "100";  -- Red Highway
                light_farm <= "001";     -- Green Farm
                light_ped <= "00";

                next_state <= HRED_FYEL;

            when HRED_FYEL =>
                light_highway <= "100";
                light_farm <= "010";  -- Yellow Farm
                light_ped <= "00";

                next_state <= HGRE_FRED;

            when PED_WALK =>
                light_highway <= "100";
                light_farm <= "100";
                light_ped <= "10";  -- Walk signal

                if ped_countdown = "0000" then
                    next_state <= PED_BLINK;
                else
                    next_state <= PED_WALK;
                end if;

            when PED_BLINK =>
                light_ped <= "01";  -- Blinking Walk
                if ped_countdown = "0000" then
                    next_state <= PED_STOP;
                else
                    next_state <= PED_BLINK;
                end if;

            when PED_STOP =>
                light_ped <= "00";  -- Don't Walk
                next_state <= HGRE_FRED;

            when EMERGENCY_OVERRIDE =>
                light_highway <= "000"; -- All lights off
                light_farm <= "000";
                light_ped <= "00";

                if emergency_signal = '0' then
                    next_state <= HGRE_FRED;
                else
                    next_state <= EMERGENCY_OVERRIDE;
                end if;

            when others =>
                next_state <= HGRE_FRED;
        end case;
    end process;

    -- Assign outputs
    countdown_veh_highway <= std_logic_vector(veh_highway_countdown);
    countdown_veh_farm <= std_logic_vector(veh_farm_countdown);
    countdown_ped <= std_logic_vector(ped_countdown);

end traffic_light;
