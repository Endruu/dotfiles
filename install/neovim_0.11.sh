#!/bin/bash

set -e

is_nvim_installed() {
    command -v nvim &>/dev/null
}

# Function to forcefully remove nvim
uninstall_nvim() {
    echo "Uninstalling Neovim..."
    rm /usr/bin/nvim
    rm /usr/share/nvim
    rm -r /usr/nvim-linux64
    rm -rf ~/.local/share/nvim
    rm -rf ~/.cache/nvim
    echo "Neovim has been forcefully uninstalled."
}

if is_nvim_installed; then
    if [ "$1" == "-f" ] || [ "$1" == "--force" ]; then
        uninstall_nvim
    else
        echo "Neovim is already installed. Use -f or --force to uninstall."
        exit 1
    fi
else
    TEMP_DIR=$(mktemp -d)
    cd $TEMP_DIR
    trap 'cd - && rm -rf "$TEMP_DIR"' EXIT

    wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux64.tar.gz
    tar xvzf nvim-linux64.tar.gz
    cp -r nvim-linux64/* /usr/
    echo "Neovim installed successfully."
fi
