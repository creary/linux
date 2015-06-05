#!/bin/bash
# 用于挂载windows分区


WINDOWS_F=/media/mang/windows/f

# 如果目录不存在就先创建目录
if [ ! -d $WINDOWS_F ];then
   mkdir -p $WINDOWS_F
fi

mount /dev/sda7  $WINDOWS_F &>/dev/null
