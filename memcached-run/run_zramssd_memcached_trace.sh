#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 [postfix] [zram/ram] [dram] [time]"
    exit 1
fi
postfix=$1
cgroupname="memcached_ycsb"
ramcapicity=$2
memcapicity=$3
maxexecutiontime=$4
script_path=$(readlink -f "$0")
# 提取当前脚本所在目录
scriptdir=$(dirname "$script_path")

# 关闭目前运行的memcached-server
sudo ./stop_memcached_cgroup.sh
# 配置swap环境
sudo ./zramon_x.sh $ramcapicity
sudo ./restart_cgroup_x_swap.sh $memcapicity 1000

sleep 1

# 在配置好的环境中启动memcached
sudo cgexec -g cpu:$cgroupname /usr/bin/memcached -m 2048 -v -p 11211 -u memcache -l 127.0.0.1 -P /var/run/memcached/memcached.pid &

sudo ./set_trace_lock.sh
# sudo ./set_trace.sh
sudo sh -c "echo 1 > /sys/kernel/debug/tracing/tracing_on"
sudo sh -c "cat /sys/kernel/debug/tracing/trace_pipe > trace_record_p.txt &"

pushd /home/yuri/YCSB
sudo ./bin/ycsb load memcached -s -P workloads/workload_memcached_expo  -p "memcached.hosts=127.0.0.1" -threads 4 -p "memcached.host=127.0.0.1" > $scriptdir/outputLoad.txt 2>&1

sleep 3
# sudo ./bin/ycsb run memcached -s -P workloads/workload_memcached_hotspot  -p "memcached.hosts=127.0.0.1" -threads 4 -p "memcached.host=127.0.0.1" -p maxexecutiontime=$maxexecutiontime > $scriptdir/outputRun-$ramcapicity-$memcapicity-$postfix 2>&1
sudo ./bin/ycsb run memcached -s -P workloads/workload_memcached_expo  -p "memcached.hosts=127.0.0.1" -threads 4 -p "memcached.host=127.0.0.1" -p maxexecutiontime=$maxexecutiontime > $scriptdir/outputRun-$ramcapicity-$memcapicity-$postfix 2>&1

echo "after test cgroup peak[$(cat /sys/fs/cgroup/$cgroupname/memory.peak)]"
popd
sudo sh -c "echo 0 > /sys/kernel/debug/tracing/tracing_on"

sudo cp /sys/fs/cgroup/$cgroupname/memory.stat ./endmemstat.$ramcapicity-$memcapicity-$postfix
sleep 5