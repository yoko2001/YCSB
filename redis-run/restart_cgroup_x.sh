#!/bin/bash
# 检查参数是否为内存
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [arg]"
    exit 1
fi

memory_limit=$1

cgroup_name="redis_ycsb"
nvme_major_minor="253:2"

# 检查是否存在名为 redis_ycsb 的 cgroup
if [ -d /sys/fs/cgroup/$cgroup_name ]; then
    echo "Found cgroup $cgroup_name"

    # 获取 cgroup 内部的所有进程并杀死它们
    pids=$(cat /sys/fs/cgroup/$cgroup_name/cgroup.procs)
    for pid in $pids; do
        kill -9 $pid
        echo "kill $pid"
    done
    sleep 1
    # 删除现有的 cgroup
    cgdelete cpu:$cgroup_name
fi

# 创建一个新的 cgroup
cgcreate -g cpu:$cgroup_name
echo "Created new cgroup $cgroup_name"

echo $(($memory_limit * 1024 * 1024)) > /sys/fs/cgroup/$cgroup_name/memory.max
echo $((300 * 1024 * 1024)) > /sys/fs/cgroup/$cgroup_name/memory.swap.max
# echo "$nvme_major_minor  rbps=23068672" > /sys/fs/cgroup/$cgroup_name/io.max
# echo "$nvme_major_minor  rbps=26214400" > /sys/fs/cgroup/$cgroup_name/io.max
# echo "$nvme_major_minor  rbps=20971520" > /sys/fs/cgroup/$cgroup_name/io.max
# echo "$nvme_major_minor  rbps=28311552" > /sys/fs/cgroup/$cgroup_name/io.max

echo "$nvme_major_minor  rbps=31457280" > /sys/fs/cgroup/$cgroup_name/io.max

echo "Created new cgroup $(cat /sys/fs/cgroup/$cgroup_name/memory.max)"

