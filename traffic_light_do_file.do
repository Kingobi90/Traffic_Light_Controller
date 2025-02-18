add wave /traffic_light_tb/sensor
add wave /traffic_light_tb/ped_btn
add wave /traffic_light_tb/emergency_signal
add wave /traffic_light_tb/clk
add wave /traffic_light_tb/rst_n
add wave /traffic_light_tb/light_highway
add wave /traffic_light_tb/light_farm
add wave /traffic_light_tb/light_ped
add wave /traffic_light_tb/countdown_veh_highway
add wave /traffic_light_tb/countdown_veh_farm
add wave /traffic_light_tb/countdown_ped

force /traffic_light_tb/sensor 0
force /traffic_light_tb/ped_btn 0
force /traffic_light_tb/emergency_signal 0
force /traffic_light_tb/clk 0
force /traffic_light_tb/rst_n 0
run 20 ns

force /traffic_light_tb/rst_n 1
run 50 ns

force /traffic_light_tb/countdown_veh_highway 10
force /traffic_light_tb/countdown_veh_farm 10
force /traffic_light_tb/countdown_ped 4
run 50 ns

force /traffic_light_tb/sensor 0
force /traffic_light_tb/ped_btn 0
force /traffic_light_tb/emergency_signal 0
run 100 ns

force /traffic_light_tb/sensor 1
run 100 ns  

force /traffic_light_tb/sensor 0
run 100 ns

force /traffic_light_tb/ped_btn 1
run 50 ns  

force /traffic_light_tb/ped_btn 0
run 100 ns

force /traffic_light_tb/emergency_signal 1
run 50 ns

force /traffic_light_tb/emergency_signal 0
run 100 ns

force /traffic_light_tb/sensor 1
force /traffic_light_tb/ped_btn 1
run 100 ns  

force /traffic_light_tb/sensor 0
force /traffic_light_tb/ped_btn 0
run 100 ns

force /traffic_light_tb/sensor 1
run 100 ns

force /traffic_light_tb/sensor 0
run 100 ns

force /traffic_light_tb/ped_btn 1
run 100 ns

force /traffic_light_tb/ped_btn 0
run 100 ns

force /traffic_light_tb/emergency_signal 1
run 100 ns

force /traffic_light_tb/emergency_signal 0
run 100 ns

force /traffic_light_tb/sensor 1
run 100 ns

force /traffic_light_tb/sensor 0
run 100 ns

force /traffic_light_tb/ped_btn 1
run 50 ns

force /traffic_light_tb/ped_btn 0
run 100 ns

force /traffic_light_tb/emergency_signal 1
run 50 ns

force /traffic_light_tb/emergency_signal 0
run 100 ns

force /traffic_light_tb/sensor 0
force /traffic_light_tb/ped_btn 0
force /traffic_light_tb/emergency_signal 0
run 200 ns  

force /traffic_light_tb/sensor 1
force /traffic_light_tb/emergency_signal 1
run 100 ns

force /traffic_light_tb/emergency_signal 0
run 100 ns

force /traffic_light_tb/emergency_signal 1
force /traffic_light_tb/ped_btn 1
run 100 ns

force /traffic_light_tb/ped_btn 0
force /traffic_light_tb/emergency_signal 0
run 100 ns

force /traffic_light_tb/ped_btn 1
run 50 ns
force /traffic_light_tb/ped_btn 0
run 50 ns
force /traffic_light_tb/ped_btn 1
run 50 ns
force /traffic_light_tb/ped_btn 0
run 100 ns

force /traffic_light_tb/rst_n 0
run 50 ns
force /traffic_light_tb/rst_n 1
run 50 ns
force /traffic_light_tb/emergency_signal 1
run 100 ns

force /traffic_light_tb/emergency_signal 0
run 100 ns

force /traffic_light_tb/sensor 0
run 500 ns

wait;


