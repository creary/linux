#! /bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    printf "Error: You must be root to run this script!\n"
    exit 1
fi

# Source function library.
. /etc/init.d/functions

# Source Env
. /etc/profile

function defaultHosts(){
echo > /etc/hosts

cat >> /etc/hosts << EOF
# Do not remove the following line, or various programs
# that require network functionality will fail.
127.0.0.1            localhost.localdomain localhost
::1                  localhost6.localdomain6 localhost6
192.168.18.248    git.up360.com        
192.168.18.248    team.up360.com  
EOF
}

function modifyHosts(){

echo -n "[ /etc/hosts modified to $IP ]"; success; echo;

echo "
$1     www.up360.com
$1     data.up360.com
$1     static.up360.com
$1     m.up360.com
$1     parent.up360.com
$1     download.up360.com
192.168.18.243    fms.up360.com
      
" >> /etc/hosts
}
#local
function modifyLocalHosts(){

echo -n "[ /etc/hosts modified to $IP ]"; success; echo;

echo "
$1     www.up360.com
192.168.18.223     data.up360.com
192.168.18.223     static.up360.com
$1     m.up360.com
$1     parent.up360.com
$1     download.up360.com
192.168.18.243    fms.up360.com
       
" >> /etc/hosts
}
printf "Please enter Env IP：\n"
printf "Desc: 1-13,2-223,3-Online,4-47,5-Local \n"
        read ipNum

        while [[ "x"$ipNum != "x1" && "x"$ipNum != "x2" && "x"$ipNum != "x3" && "x"$ipNum != "x4" && "x"$ipNum != "x5" ]]
        do
                printf "InputError: 1-13,2-223,3-Online,4-47,5-Local \n"
                read ipNum
        done

        if [ "x"$ipNum == "x1" ];then
                IP=192.168.18.13
		defaultHosts
		modifyHosts $IP
        elif [ "x"$ipNum == "x2" ];then
                IP=192.168.18.223
		defaultHosts
 		modifyHosts $IP
        elif [ "x"$ipNum == "x3" ];then
		defaultHosts
        elif [ "x"$ipNum == "x4" ];then
                IP=192.168.18.47
		defaultHosts
		modifyHosts $IP
        elif [ "x"$ipNum == "x5" ];then
                IP=127.0.0.1
		defaultHosts
		modifyLocalHosts $IP
        fi
