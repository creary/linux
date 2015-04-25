#!/usr/bin/env zsh

#安装vim
echo "\n\033[0;34m安装vim...\033[0m"
brew install vim

#安装oh-my-zsh
echo "\n\033[0;34m安装zsh...\033[0m"
brew install zsh
echo "  \033[0;34m安装curl，用来安装oh-my-zsh\033[0m"
brew install curl
echo "  \033[0;34m安装zsh的配置oh-my-zsh...\033[0m"
curl -L http://install.ohmyz.sh | sh

#设置当前用户的登录shell为zsh
echo "\033[0;33m设置当前用户的登录shell为zsh\033[0m"
sudo chsh -s `which zsh` $USER

#安装tmux
echo "\n\033[0;34m安装tmux...\033[0m"
brew install tmux

#配置已经安装好的软件
echo "\n\033[0;34m软件已经安装完成，开始配置已经安装好的软件...\033[0m"
exec $CURDIR/config.sh
