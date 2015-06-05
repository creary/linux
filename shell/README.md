cc_iptables
===========

收集处理DDOS、CC攻击各类脚本，包括NGINX日志中的CC攻击IP处理。


git@git.oschina.net:ppabc/cc_iptables.git

git@github.com:ppabc/cc_iptables.git


common_clear
============

shell编写的linux下文件定期删除脚本，可指定多个目录，多每个目录可以设定任意扫描深度，对目录及待删除文件可自定义正则匹配表达式
oneshell
========
- 简介
一些Linux Bash Shell 一键脚本,所有脚本只支持CentOS，RedHat未做测试，理论没问题。  
主要是自用，避免重复劳动，定制自己需要的脚本。 

- 其他项目推荐
- 推荐1 [https://github.com/lj2007331/lnmp](https://github.com/lj2007331/lnmp) 非常推荐,很强大！无web管理。
- 推荐2 [http://lnmp.org](http://lnmp.org) 广泛在vps上使用。无web管理。
- 推荐3 [http://www.vpsmate.org/](http://www.vpsmate.org/) vps伴侣，采用二进制包，带web管理面板，速度很快。
- 推荐4 [http://www.amysql.com/AMH.htm](http://www.amysql.com/AMH.htm) AMH 带web管理面板。
- 推荐5 自己的路，wdcp 比较臃肿庞大，适合小白。

脚本文件单个介绍
========

init.sh
--------
- 初始化CentOS linux生产环境。只能用于新系统初始化。
- 其中包括内容有：
- 设置时区为UTC+8,ntpdate 同步
- 禁用SeLinux
- yum 安装常用库
- 禁用ipv6
- 优化打开文件数
- 禁用不必要的services
- 优化sysctl

rmamp.sh
--------
删除yum二进制包方式安装的apache（httd），mysql，php  

lnmp2centos.sh
--------------
本LNMP一键安装脚本，安装的软件为：  
Nginx(Tengine new)：       使用最新版，Tengine是taobao维护的版本，全兼容nginx的配置，更多特性，推荐使用。  
MySQL(Percona Server5.6)： "Percona Server" oschina、douban都在使用，我也选她。全兼容官方mysql配置。  
PHP(php5.5.x)              使用php5.5.x最新版。  

使用方法：  
wget -c https://github.com/wwek/oneshell/archive/master.zip; yum -y install  unzip;unzip master.zip;cd oneshell-master;sh init.sh;sh lnmp2centos.sh  
特别注意：lnmp2centos.sh 不能单独使用，必须和 init.sh 配合使用。   
mysql配置文件推荐使用 https://tools.percona.com/  生成，也支持原版mysql的，一样用，实际上配置都是通用的。  
参考
====
参考lnmp.org定制本一键脚本。  

# Linux下常用软件的安装和配置

## 项目说明
这个项目主要是用来安装linux下一些常用的软件，以及自己对这些软件的配置,会安装的软件如下
* zsh 配置使用[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* vim 配置使用[vimconfig](https://github.com/yujunyong/vimconfig)
* tmux 配置使用[tmux.conf](https://github.com/yujunyong/shellenv/blob/master/tmux.conf.template)

## 安装
1. 使用git克隆本项目
2. 进入项目目录输入`./install.sh`进行安装
3. 安装完成后关闭终端，重新打开后就能正常使用
