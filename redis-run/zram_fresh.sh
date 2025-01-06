#!/bin/bash

SWAP_DEVICE="/dev/zram0"
SWAP_PRIORITY=$(swapon | grep "$SWAP_DEVICE" | awk '{print $5}')
sleep 100
while true
do
    # Check if zram0 exists
    if [[ -e $SWAP_DEVICE ]]; then
        echo "Swap device $SWAP_DEVICE exists with priority $SWAP_PRIORITY"
        
        # Disable and enable zram0
        echo "Disabling $SWAP_DEVICE"
        sudo swapoff $SWAP_DEVICE
        sleep 3
        echo "Enabling $SWAP_DEVICE with priority $SWAP_PRIORITY"
        sudo swapon -p $SWAP_PRIORITY  $SWAP_DEVICE

    else
        echo "Swap device $SWAP_DEVICE not found"
    fi
    sleep 100
done