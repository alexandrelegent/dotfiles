#!/bin/zsh

# Oh My Zsh

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="fox"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

export USERNAME="alegent"
export FULL_NAME="Alexandre Legent"
export MAIL="alexandrelegent@gmail.com"
export TZ="Europe/Paris"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="hx"
export VISUAL="hx"
export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export TERM=xterm-256color

# Paths

export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/.dotfiles/scripts:$PATH"

# Command Completion

if [ "$(command -v atuin)" ]; then
  eval "$(atuin init zsh)"
fi
if [ "$(command -v fuck)" ]; then
  eval $(thefuck --alias)
fi

if [ "$(command -v mise)" ]; then
  eval "$(mise activate zsh)"
fi

if [ "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# Alias

alias ll="ls -l"
alias la="ls -la"
alias cl="clear"

if [ "$(command -v bat)" ]; then
  alias cat="bat"
fi

if [ "$(command -v eza)" ]; then
  alias ls="eza"
  alias lT="eza -lT"
fi

if [ "$(command -v trash)" ]; then
  alias rm="trash"
fi

if [ "$(command -v lazygit)" ]; then
  alias lg="lazygit"
fi

# SSH Agent

if [ -x "$(command -v ssh-add)" ]; then
  if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval "$(ssh-agent)"
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi

  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
  ssh-add -l > /dev/null || ssh-add
fi
