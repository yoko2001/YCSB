#!/bin/bash
# sudo echo 0 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run1 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run2 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run3 200 400 600


# sudo echo 1 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run1 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run2 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run3 200 400 600
# echo 0 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh final-expo-default-10min-run3 300 500 600

# echo 1 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh final-expo-route-10min-run3 300 500 600

# echo 0 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh final-expo-default-10min-run5 300 500 600

# echo 1 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh final-expo-route-10min-run5 300 500 600
echo 0 > /sys/kernel/debug/clever_swap_alloc
echo 0 > /sys/kernel/debug/swap_scan_savior_enabled
sudo ./run_zramssd_memcached.sh final-expo-default-10min-run1 300 500 600

echo 1 > /sys/kernel/debug/clever_swap_alloc
echo 0 > /sys/kernel/debug/swap_scan_savior_enabled
sudo ./run_zramssd_memcached.sh final-expo-route-10min-run1 300 500 600

echo 1 > /sys/kernel/debug/clever_swap_alloc
echo 1 > /sys/kernel/debug/swap_scan_savior_enabled
sudo ./run_zramssd_memcached.sh final-expo-migroute-10min-run1 300 500 600
