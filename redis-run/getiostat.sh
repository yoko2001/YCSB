#!/bin/bash
echo "" > iostat.log
while true
do
    iostat -d /dev/vdb /dev/zram0 1 1 | awk '/vdb|zram0/ {print $3, $4}' >> iostat.log
    sleep 5
done
