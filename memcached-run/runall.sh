#!/bin/bash
# sudo echo 0 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run1 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run2 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-default-zramssd-12min-run3 200 400 600


# sudo echo 1 > /sys/kernel/debug/clever_swap_alloc
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run1 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run2 200 400 600
# sudo ./run_zramssd_memcached.sh zipfian-route-zramssd-12min-run3 200 400 600

sudo ./run_zramssd_memcached.sh hotspot-default-zramssd-10min-run1 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-default-zramssd-10min-run2 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-default-zramssd-10min-run3 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-default-zramssd-10min-run4 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-default-zramssd-10min-run5 150 400 300
echo 1 > /sys/kernel/debug/clever_swap_alloc
sudo ./run_zramssd_memcached.sh hotspot-route-zramssd-10min-run1 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-route-zramssd-10min-run2 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-route-zramssd-10min-run3 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-route-zramssd-10min-run4 150 400 300
sudo ./run_zramssd_memcached.sh hotspot-route-zramssd-10min-run5 150 400 300
