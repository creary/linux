#!/bin/bash
#########################################
#Function:    update yum source
#Usage:       bash update_yum_source.sh
#Author:      Customer service department
#Company:     Alibaba Cloud Computing
#Version:     2.0
#########################################
check_os_release()
{
  while true
  do
  os_release=$(grep "Red Hat Enterprise Linux Server release" /etc/issue 2>/dev/null)
  os_release_2=$(grep "Red Hat Enterprise Linux Server release" /etc/redhat-release 2>/dev/null)
  if [ "$os_release" ] && [ "$os_release_2" ]
  then
    echo "$os_release"
    break
  fi
  os_release=$(grep "CentOS release" /etc/issue 2>/dev/null)
  os_release_2=$(grep "CentOS release" /etc/*release 2>/dev/null)
  if [ "$os_release" ] && [ "$os_release_2" ]
  then
    echo "$os_release"
    break
  fi
  break
  done
}

modify_rhel5_yum()
{
  rpm --import http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-5
  cd /etc/yum.repos.d/
  wget http://mirrors.163.com/.help/CentOS-Base-163.repo -O CentOS-Base-163.repo
  sed -i '/mirrorlist/d' CentOS-Base-163.repo
  sed -i 's/\$releasever/5/' CentOS-Base-163.repo
  yum clean metadata
  yum makecache
  cd ~
}

modify_rhel6_yum()
{
  rpm --import http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-6
  cd /etc/yum.repos.d/
  wget http://mirrors.163.com/.help/CentOS-Base-163.repo -O CentOS-Base-163.repo
  sed -i '/mirrorlist/d' CentOS-Base-163.repo
  sed -i '/\[addons\]/,/^$/d' CentOS-Base-163.repo
  sed -i 's/\$releasever/6/' CentOS-Base-163.repo
  sed -i 's/RPM-GPG-KEY-CentOS-5/RPM-GPG-KEY-CentOS-6/' CentOS-Base-163.repo
  yum clean metadata
  yum makecache
  cd ~
}

##########start######################
#check lock file ,one time only let the script run one time 
LOCKfile=/tmp/.update_yum_source_lock
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

os_type=$(check_os_release)
if [ "X$os_type" == "X" ]
then
  echo -e "\033[1;40;31mOS type is not RedHat or CentOS,So this script is not executede.\n\033[0m"
  rm -rf $LOCKfile
  exit 0
else
  echo -e "\033[40;32mThis OS is $os_type.\033[40;37m"
  echo "$os_type" |grep 5 >/dev/null
  if [ $? -eq 0 ]
  then
    modify_rhel5_yum
    rm -rf $LOCKfile
    exit 0
  fi
  echo "$os_type"|grep 6 >/dev/null
  if [ $? -eq 0 ]
  then
    modify_rhel6_yum
    rm -rf $LOCKfile
    exit 0
  fi
fi
rm -rf $LOCKfile