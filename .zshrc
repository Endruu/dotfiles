ZINIT_HOME=$HOME/.local/share/zinit

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME
fi

source $ZINIT_HOME/zinit.zsh

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit snippet OMZP::python

autoload -Uz compinit && compinit

zinit cdreplay -q

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Make autocomplete case insensitive and colored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

eval "$(zoxide init --cmd cd zsh)"

bindkey -v

bindkey ^R history-incremental-search-backward
bindkey ^S history-incremental-search-forward


source $HOME/.cargo/env
source $HOME/.local/bin/env

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin/

alias ll="eza -lah --git --group-directories-first"
alias lg=lazygit
alias nn="nvim ."
alias pip="uv pip"
alias venv="uv venv"
alias :q=exit
