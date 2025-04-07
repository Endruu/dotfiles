# TODOs

- [ ] Create bootstrap script
  - [ ] Setup ssh key (likely needed for github auth)
  - [ ] Download git
  - [ ] Download this repo
- [ ] Use `ln -s` or `stow` instead of `cp`
- [ ] Check for mandatory files or info needed for setup, but not part of the repo (e.g. private info)
- [X] Add lazy-docker
- [ ] Take care of distro update

# Possible problems and fixes

- [Can't start fzf](https://github.com/ibhagwan/fzf-lua/issues/1243#issuecomment-2168891260)
  ```
  sudo mkdir /run/user/1000
  sudo chown -R endruu /run/user/1000
  ```
