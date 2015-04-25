#! /bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

echo "*******************************************************"
echo "********************清理前的内存情况：*****************"
echo "*******************************************************"

free -h

sync

echo 3 > /proc/sys/vm/drop_caches 

echo "*******************************************************"
echo "********************清理后的内存情况：*****************"
echo "*******************************************************"

free -h

#echo 0 > /proc/sys/vm/drop_caches 
