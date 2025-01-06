#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [postfix]"
    exit 1
fi
postfix=$1
cgroupname="redis_ycsb"
zramcapicity=$2
memcapicity=$3
script_path=$(readlink -f "$0")
# 提取当前脚本所在目录
scriptdir=$(dirname "$script_path")


sudo ./zramon_x.sh $zramcapicity
sudo ./restart_cgroup_x.sh $memcapicity
sleep 1

sudo ./restart_redis_cgroup.sh
sleep 1

sudo ./set_trace.sh

sudo sh -c "echo 1 > /sys/kernel/debug/tracing/tracing_on"
sudo sh -c "cat /sys/kernel/debug/tracing/trace_pipe > trace_record_p.txt &"

pushd /home/yuri/YCSB
sudo ./bin/ycsb load redis -s -P workloads/workload_redis_expo -p "redis.host=127.0.0.1" -p "redis.port=6379" > $scriptdir/outputLoad.txt 2>&1
sleep 5
sudo ./bin/ycsb run redis -s -P workloads/workload_redis_expo -p "redis.host=127.0.0.1" -p "redis.port=6379" > $scriptdir/outputRun-$zramcapicity-$memcapicity-$postfix 2>&1

echo "after test cgroup peak[$(cat /sys/fs/cgroup/$cgroupname/memory.peak)]"
popd

sudo sh -c "echo 0 > /sys/kernel/debug/tracing/tracing_on"

sudo cp /sys/fs/cgroup/$cgroupname/memory.stat ./endmemstat.$zramcapicity-$memcapicity-$postfix
sleep 5