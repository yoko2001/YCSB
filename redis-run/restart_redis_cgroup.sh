#!/bin/bash
cgroup_name="redis_ycsb"

# 使用 ps 命令查找正在运行的 redis-server 进程，并获取其 PID
redis_pid=$(ps -ef | grep 'redis-server' | grep -v grep | awk '{print $2}')

if [ -z "$redis_pid" ]; then
    echo "Redis server is not running."
    exit 1
else
    echo "Redis server is running with PID: $redis_pid"
fi

if [ -d /sys/fs/cgroup/$cgroup_name ]; then
    echo "+$redis_pid" > /sys/fs/cgroup/$cgroup_name/cgroup.procs
    echo "Redis server is running in cgroup : [$(cat /sys/fs/cgroup/$cgroup_name/cgroup.procs)]"
    cat /sys/fs/cgroup/$cgroup_name/memory.stat > endmemstat.txt
fi