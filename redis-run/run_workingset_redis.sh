#!/bin/bash
cgroup_name="redis_ycsb"

sudo ./restart_cgroup_x.sh 4096
sudo ./restart_redis_cgroup.sh
sleep 1

cd /home/yuri/YCSB
./bin/ycsb load redis -s -P workloads/workload_redis -p "redis.host=127.0.0.1" -p "redis.port=6379" > outputLoad.txt 2>&1
sleep 1
./bin/ycsb run redis -s -P workloads/workload_redis -p "redis.host=127.0.0.1" -p "redis.port=6379" > outputRun.txt 2>&1

echo "after test cgroup peak[$(cat cat /sys/fs/cgroup/$cgroup_name/memory.peak)]"