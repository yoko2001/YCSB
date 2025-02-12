#!/bin/bash
sudo killall java
sudo killall redis-server
sudo killall memcached
swapoff /dev/zram0
swapoff /dev/ram0

#set -e
# 检查参数的个数是否为1
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <memsize> "
    exit 1
fi
diskcapicity=$1

modprobe -r zram
sleep 1
modprobe zram num_devices=1
echo lzo-rle > /sys/block/zram0/comp_algorithm

numstream=$(cat /sys/block/zram0/max_comp_streams)
echo "numstream = ${numstream}"
algo=$(cat /sys/block/zram0/comp_algorithm)
echo "used algorythm is ${algo}"

# Initialize /dev/zram0 with 256MB disksize
echo $(($diskcapicity * 1024 * 1024)) > /sys/block/zram0/disksize
echo $(($diskcapicity * 1024 * 1024)) > /sys/block/zram0/mem_limit

#swap on
mkswap /dev/zram0
#setting the max priority
swapon -p 1000 /dev/zram0