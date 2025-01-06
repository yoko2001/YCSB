#!/bin/bash

# 清空之前的数据
> iostat_output.txt

# 启动 iostat 并将输出重定向到文件
iostat -d -p dm-2 zram0 5 1 >> iostat_output.txt

# 显示过去5秒的数据
tail -n 6 iostat_output.txt