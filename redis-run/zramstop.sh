#!/bin/bash
sudo killall java
sudo killall redis-server
sudo killall memcached
swapoff /dev/zram0
swapoff /dev/ram0