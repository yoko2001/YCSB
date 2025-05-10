#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 [postfix] [zram/ram] [dram] [time]"
    exit 1
fi
postfix=$1
cgroupname="redis_ycsb"
ramcapicity=$2
memcapicity=$3
maxexecutiontime=$4
script_path=$(readlink -f "$0")
# 提取当前脚本所在目录
scriptdir=$(dirname "$script_path")

# 关闭目前运行的redis-server
sudo ./stop_redis_cgroup.sh

# 配置swap环境
sudo ./zramon_x.sh $ramcapicity
sudo ./restart_cgroup_x_swap.sh $memcapicity 1000

sleep 1
cgroup_name="redis_ycsb"

# 在配置好的环境中启动redis
sudo cgexec -g cpu:$cgroup_name /usr/bin/redis-server /etc/redis/redis.conf &

# sudo ./set_trace_lock.sh
# sudo ./set_trace.sh
# sudo sh -c "echo 1 > /sys/kernel/debug/tracing/tracing_on"
# sudo sh -c "cat /sys/kernel/debug/tracing/trace_pipe > trace_record_p-$ramcapicity-$memcapicity-$postfix.txt &"
sudo rm iostatlog.txt
iostat -x /dev/vg0/lv-2 1 >> iostatlog.txt &
pushd /home/yuri/YCSB
sudo ./bin/ycsb load redis -s -P workloads/workload_redis_zipfian2-pre  -threads 1 -p "redis.host=127.0.0.1" -p "redis.port=6379" > $scriptdir/outputLoad.txt 2>&1
sudo ./bin/ycsb load redis -s -P workloads/workload_redis_zipfian2-r95  -threads 1 -p "redis.host=127.0.0.1" -p "redis.port=6379" > $scriptdir/outputLoad.txt 2>&1
sleep 3
sudo ./bin/ycsb run redis -s -P workloads/workload_redis_zipfian2-r95 -p "redis.host=127.0.0.1" -p "redis.port=6379" -p maxexecutiontime=$maxexecutiontime > $scriptdir/outputRun-$ramcapicity-$memcapicity-$postfix 2>&1

echo "after test cgroup peak[$(cat /sys/fs/cgroup/$cgroupname/memory.peak)]"
popd
# sudo sh -c "echo 0 > /sys/kernel/debug/tracing/tracing_on"

sudo cp /sys/fs/cgroup/$cgroupname/memory.stat ./endmemstat.$ramcapicity-$memcapicity-$postfix
sudo killall iostat
sleep 5