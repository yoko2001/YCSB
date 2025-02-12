#!/bin/bash
cgroup_name="memcached_ycsb"

# 使用 ps 命令查找正在运行的 memcached-server 进程，并获取其 PID
memcached_pid=$(ps -ef | grep 'memcached' | grep -v grep | awk '{print $2}')

if [ -z "$memcached_pid" ]; then
    echo "memcached server is not running."
    exit 1
else
    echo "memcached server is running with PID: $memcached_pid"
fi

if [ -d /sys/fs/cgroup/$cgroup_name ]; then
    echo "+$memcached_pid" > /sys/fs/cgroup/$cgroup_name/cgroup.procs
    echo "memcached server is running in cgroup : [$(cat /sys/fs/cgroup/$cgroup_name/cgroup.procs)]"
    cat /sys/fs/cgroup/$cgroup_name/memory.stat > endmemstat.txt
fi