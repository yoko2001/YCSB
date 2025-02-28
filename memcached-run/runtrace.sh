num=5
echo 0 > /sys/kernel/debug/clever_swap_alloc
sudo ./run_zramssd_memcached_trace.sh expo-default-trace-zramssd-10min-run$num 200 600 600
python ./parse_locktime.py > default.latency.run$num 
echo 1 > /sys/kernel/debug/clever_swap_alloc
sudo ./run_zramssd_memcached_trace.sh expo-route-trace-zramssd-10min-run$num 200 600 600
python ./parse_locktime.py > route.latency.run$num 

echo 1 > /sys/kernel/debug/clever_swap_alloc
echo 1 > /sys/kernel/debug/swap_scan_savior_enabled
sudo ./run_zramssd_memcached_trace.sh expo-migroute-trace-zramssd-10min-run$num 200 600 600
python ./parse_locktime.py > migroute.latency.run$num 
