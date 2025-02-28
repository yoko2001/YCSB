#!/bin/bash
# sudo echo 0 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run1 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run2 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run3 200 400 600


# sudo echo 1 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run1 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run2 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run3 200 400 600
echo 0 > /sys/kernel/debug/clever_swap_alloc
sudo ./run_zramssd_memcached.sh expo-default-zramssd-10min-run6 200 600 600

echo 1 > /sys/kernel/debug/clever_swap_alloc
sudo ./run_zramssd_memcached.sh expo-route-zramssd-10min-run6 200 600 600

echo 1 > /sys/kernel/debug/clever_swap_alloc
echo 1 > /sys/kernel/debug/swap_scan_savior_enabled
sudo ./run_zramssd_memcached.sh expo-migroute-testmigtime-10min-run1 200 600 600

