# My dotfiles

## Description

## Install

1. Clone this repository

```sh
git clone https://github.com/GryzleeVEVO/dotfiles .dotfiles
```

2. Go to the directory where the repository is cloned and simulate

```sh
stow -n -t $HOME *
```

3. If there are no conflicts, go ahead. Else, you'll need to overwrite the existing files with symlinks to the repository (the previous dotfiles *WILL BE LOST*)

```sh
stow --adopt -t $HOME * # Adopt will overwrite the stow directory if in conflict
git reset --hard        # Restore the repository
```
