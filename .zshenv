source $HOME/.cargo/env
source $HOME/.local/bin/env
source $HOME/.deno/env

export GOPATH=$HOME/.go
source $GOPATH/env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
