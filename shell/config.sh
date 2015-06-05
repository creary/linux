#!/usr/bin/env zsh

#配置vim
if hash vim >/dev/null 2>&1; then
  echo "\033[0;34m开始配置vim...\033[0m"
  if [ -d ~/.vimconfig ]; then
    echo "\033[0;33m已经有vim的配置项目~/.vimconfig\033[0m"
  else
    git clone https://github.com/yujunyong/vimconfig.git ~/.vimconfig
  fi
  env zsh ~/.vimconfig/install.sh
fi

#配置zsh
if hash zsh >/dev/null 2>&1; then
  echo "\n\033[0;34m安装zsh的配置oh-my-zsh...\033[0m"
  curl -L http://install.ohmyz.sh | sh

  echo "  \033[0;34m开始配置zsh...\033[0m"
  echo "  \033[0;33m备件原来的~/.zshrc到~/.zshrc.bak\033[0m"
  mv ~/.zshrc ~/.zshrc.bak

  echo "  \033[0;34m使用zshrc配置文件模板生成~/.zshrc文件\033[0m"
  cp zshrc.template  ~/.zshrc
fi

#配置tmux
if hash tmux >/dev/null 2>&1; then
  echo "\n\033[0;34m开始配置tmux...\033[0m"
  echo "  \033[0;34m查找是否已经存在tmux配置文件...\033[0m"
  if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
    echo "\033[0;33m发现已存在'~/.tmux.conf', 将它备件到~/.tmux.conf.bak\033[0m";
    mv ~/.tmux.conf ~/.tmux.conf.bak
  fi

  echo "  \033[0;34m使用tmux配置文件模板生成~/.tmux.conf文件\033[0m"
  cp tmux.conf.template ~/.tmux.conf
  sed -i -e "/default-shell/c \\
  set -g default-shell $(which zsh)
  " ~/.tmux.conf

fi

#配置完成
echo "\033[0;34m安装完成，请退出shell后重新登录使配置生效\033[0m"

