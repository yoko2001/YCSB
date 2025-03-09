# num=5

echo 0 > /sys/kernel/debug/clever_swap_alloc
sudo ./run_zramssd_memcached_trace.sh final-expo-default-10min-trace 300 500 600
python parse_locktime.py > lockdefault

echo 1 > /sys/kernel/debug/clever_swap_alloc
sudo ./run_zramssd_memcached_trace.sh final-expo-route-10min-trace 300 500 600
python parse_locktime.py > lockroute

echo 1 > /sys/kernel/debug/clever_swap_alloc
echo 1 > /sys/kernel/debug/swap_scan_savior_enabled
sudo ./run_zramssd_memcached_trace.sh final-expo-migroute-10min-trace 300 500 600
python parse_locktime.py > lockmigroute

