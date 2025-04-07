#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

set -e

sudo apt update
sudo apt upgrade -yqq

sudo apt install -yqq \
	sudo \
	curl wget \
	man \
	build-essential \
	gpg ca-certificates software-properties-common libssl-dev \
	zsh \
	tmux \
	taskwarrior \
	zip unzip pigz \
	python3 python3-distutils \
	ripgrep fd-find fzf \
	clang-16 clangd-16 clang-format-16 \
	luarocks \
	git git-lfs

tmp_dir=`mktemp -d`
pushd $tmp_dir

# --- Install nvm, npm, node, deno

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install node

curl -fsSL https://deno.land/install.sh | sh

# --- Install rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup.sh
sh rustup.sh -y
source $HOME/.cargo/env

# --- Install go

wget https://go.dev/dl/go1.23.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.go

# --- Install common tools missing from apt

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

./install/non_apt_packages.sh

curl -LsSf https://astral.sh/uv/0.5.14/install.sh | sh
source $HOME/.local/bin/env

# --- Install nvim

sudo ./install/neovim_0.11.sh

# --- Setup git

source $SCRIPT_DIR/setup_git.sh
source $SCRIPT_DIR/.private/setup_git.sh

# --- Install Docker

sudo $SCRIPT_DIR/install_docker.sh
sudo usermod -aG docker $USER

# -- Copy config files

# TODO: Change to ln -s or stow
sudo cp $SCRIPT_DIR/wsl.conf /etc/wsl.conf
cp $SCRIPT_DIR/.zshrc $HOME/
cp $SCRIPT_DIR/.env $HOME/
cp $SCRIPT_DIR/.p10k.zsh $HOME/
cp -r $SCRIPT_DIR/nvim $HOME/.config/
cp -r $SCRIPT_DIR/tmux $HOME/.config/


popd
rm -rf $tmp_dir

sudo chsh -s $(which zsh) endruu

