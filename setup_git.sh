git lfs install

git config --global alias.s "switch"
git config --global alias.pr "pull --rebase --autostash"

git config --global alias.l "log --oneline"
git config --global alias.ll "log --graph --oneline"
git config --global alias.lll "log --all --decorate --oneline --graph"

git config --global alias.cm "merge --continue"
git config --global alias.cr "rebase --continue"
git config --global alias.am "merge --abort"
git config --global alias.ar "rebase --abort"

git config --global core.editor "nvim --clean"
git config --global rerere.enabled true
