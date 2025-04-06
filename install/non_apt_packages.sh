#!/bin/bash

set -e

go install github.com/jesseduffield/lazygit@latest
go install github.com/jesseduffield/lazydocker@latest
go install github.com/gokcehan/lf@latest

cargo install eza
cargo install bottom
