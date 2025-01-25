#!/bin/bash
swapoff /dev/ram0
swapoff /dev/zram0

# 检查 root 权限
if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 权限运行此脚本"
  exit 1
fi
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <memsize>"
    exit 1
fi

diskcapacity=$1
# 杀死进程
killall java
killall redis-server
killall memcached


# 关闭之前的 swap
swapoff /dev/ram0 2>/dev/null

# 检查参数个数

sudo rmmod brd
# 加载 brd 模块并创建 RAM 磁盘
modprobe brd rd_nr=1 rd_size=$(($diskcapacity * 1024))  # 将 100 替换为所需的大小（MB）
# 创建 RAM swap

mkswap /dev/ram0

# 启用 RAM swap 文件
swapon -p 1005  /dev/ram0