#!/bin/bash
#########################################
#Function:    add a new swap partition
#Usage:       bash add_swap.sh
#Author:      Customer service department
#Company:     Alibaba Cloud Computing
#Version:     1.0
#########################################

check_os_release()
{
  while true
  do
    if cat /proc/version | grep redhat >/dev/null 2>&1
    then
      os_release=redhat
      echo "$os_release"
      break
    fi
    if cat /proc/version | grep centos >/dev/null 2>&1
    then
      os_release=centos
      echo "$os_release"
      break
    fi
    if cat /proc/version | grep ubuntu >/dev/null 2>&1
    then
      os_release=ubuntu
      echo "$os_release"
      break
    fi
    if cat /proc/version | grep -i debian >/dev/null 2>&1
    then
      os_release=debian
      echo "$os_release"
      break
    fi
    break
    done
}

check_memory_and_swap()
{
  mem_count=$(free -m|grep Mem|awk '{print $2}')
  swap_count=$(free -m|grep Swap|awk '{print $2}')
  count=$((swap_count/mem_count))
  if [ "$count" -ge 2 ]
  then
    echo -e "\033[1;40;31mYour swap is already enough.Do not need to add swap.Script will exit.\n\033[0m"
    rm -rf $LOCKfile
    exit 1
  else
    echo -e "\033[40;32mYour swap is not enough,need to add swap.\n\033[40;37m"
  fi
}

create_swap()
{
  if [ -e /var/swapfile ]
  then
    if [ ! -e /var/swap_file ]
    then
      swapfile=/var/swap_file
      dd if=/dev/zero of=$swapfile bs=2M count=$mem_count
      /sbin/mkswap $swapfile
      /sbin/swapon $swapfile
      /sbin/swapon -s
      $1 $swapfile
      echo -e "\033[40;32mStep 3.Add swap partition successful.\n\033[40;37m"
    else
      echo -e "\033[1;40;31mThe /var/swapfile and /var/swap_file already exists.Will exit.\n\033[0m"
      rm -rf $LOCKfile
      exit 1
    fi
  else
    swapfile=/var/swapfile
    if ! dd if=/dev/zero of=$swapfile bs=2M count=$mem_count
    then
      echo -e "\033[1;40;31mCan not to create $swapfile,script will exit.\n\033[0m"
      rm -rf $LOCKfile
      exit 1
    fi
    /sbin/mkswap $swapfile
    /sbin/swapon $swapfile
    /sbin/swapon -s
    $1 $swapfile
    echo -e "\033[40;32mStep 3.Add swap partition successful.\n\033[40;37m"
  fi
}

config_rhel_fstab()
{
  if ! grep $1 /etc/fstab >/dev/null 2>&1
  then
    echo -e "\033[40;32mBegin to modify /etc/fstab.\n\033[40;37m"
    echo "$1	 swap	 swap defaults 0 0" >>/etc/fstab
  else
    echo -e "\033[1;40;31m/etc/fstab is already configured.\n\033[0m"
    rm -rf $LOCKfile
    exit 1
  fi
}

config_debian_fstab()
{
  if ! grep $1 /etc/fstab >/dev/null 2>&1
  then
    echo -e "\033[40;32mBegin to modify /etc/fstab.\n\033[40;37m"
    echo "$1	 none	 swap sw 0 0" >>/etc/fstab
  else
    echo -e "\033[1;40;31m/etc/fstab is already configured.\n\033[0m"
    rm -rf $LOCKfile
    exit 1
  fi
}

##########start######################
#check lock file ,one time only let the script run one time 
LOCKfile=/tmp/.add_swap_lock
if [ -f "$LOCKfile" ]
then
  echo -e "\033[1;40;31mThe script is already exist,please next time to run this script.\n\033[0m"
  exit
else
  echo -e "\033[40;32mStep 1.No lock file,begin to create lock file and continue.\n\033[40;37m"
  touch $LOCKfile
fi

#check user
if [ $(id -u) != "0" ]
then
  echo -e "\033[1;40;31mError: You must be root to run this script, please use root to install this script.\n\033[0m"
  rm -rf $LOCKfile
  exit 1
fi

os_release=$(check_os_release)
if [ "X$os_release" == "X" ]
then
  echo -e "\033[1;40;31mThe OS does not identify,So this script is not executede.\n\033[0m"
  rm -rf $LOCKfile
  exit 0
else
  echo -e "\033[40;32mStep 2.Check this OS type.\n\033[40;37m"
  echo -e "\033[40;32mThis OS is $os_release.\n\033[40;37m"
fi

check_memory_and_swap

case "$os_release" in
redhat|centos)
  create_swap config_rhel_fstab
  ;;
ubuntu|debian)
  create_swap config_debian_fstab
  ;;
esac
rm -rf $LOCKfile
free -m