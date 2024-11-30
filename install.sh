#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

set -e

sudo apt update
sudo apt upgrade -yqq

sudo apt install -yqq \
	sudo \
	curl wget \
	build-essential \
	gpg ca-certificates software-properties-common \
	zsh \
	tmux \
	taskwarrior \
	zip unzip \
	python3 python3-distutils \
	ripgrep fd-find fzf \
	clang-16 clangd-16 clang-format-16 \
	git git-lfs

tmp_dir=`mktemp -d`
pushd $tmp_dir

# --- Install rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup.sh
sh rustup.sh -y
source $HOME/.cargo/env

# --- Install go

wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.go

# --- Install common tools missing from apt

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

cargo install eza
cargo install bottom

go install github.com/jesseduffield/lazygit@latest
go install github.com/gokcehan/lf@latest

curl -LsSf https://astral.sh/uv/0.5.4/install.sh | sh
source $HOME/.local/bin/env

# --- Install nvim

wget https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
sudo cp -r nvim-linux64/* /usr/

# --- Setup git

source $SCRIPT_DIR/setup_git.sh
source $SCRIPT_DIR/.private/setup_git.sh

# --- Setup wsl distro

sudo cp $SCRIPT_DIR/wsl.conf /etc/wsl.conf

# --- Install Docker

sudo $SCRIPT_DIR/install_docker.sh
sudo usermod -aG docker $USER

# -- Copy config files

cp $SCRIPT_DIR/.zshrc $HOME/
cp $SCRIPT_DIR/.zshenv $HOME/
cp $SCRIPT_DIR/.p10k.zsh $HOME/
cp $SCRIPT_DIR/go.env $GOPATH/env
cp -r $SCRIPT_DIR/nvim $HOME/.config/
cp -r $SCRIPT_DIR/tmux $HOME/.config/

popd
rm -rf $tmp_dir

sudo chsh -s $(which zsh) endruu

