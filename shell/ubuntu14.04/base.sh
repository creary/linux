#!/bin/sh
#更新库
sudo apt-get update

#安装基础编译器
sudo apt-get install g++ -y
sudo apt-get install openjdk-6-jdk -y

#安装nginx-php-mysql一条龙
sudo apt-get install apache2 -y
sudo apt-get install nginx -y
sudo apt-get install mysql-server-5.6 -y
sudo apt-get install php5 -y
sudo apt-get install php5-fpm -y
sudo apt-get install php5-gd -y
sudo apt-get install php5-imageick -y
sudo apt-get install php5-imap -y
sudo apt-get install php5-mcrypt -y
sudo apt-get install php5-mysql -y
sudo apt-get install php5-mysqlnd -y

#安装nodejs与npm
sudo apt-get install nodejs-legacy -y
sudo ln -s /usr/bin/nodejs /usr/sbin/node
sudo apt-get install npm -y
sudo npm install -g cnpm --registry=http://registry.npm.taobao.org
node -v
npm -v
cnpm -v

#安装hhvm
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
sudo add-apt-repository 'deb http://mirrors.hypo.cn/hhvm/ubuntu trusty main'
sudo apt-get update
sudo apt-get install hhvm -y

