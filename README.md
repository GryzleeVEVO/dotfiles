# My dotfiles

## Install

I use [GNU Stow](https://www.gnu.org/software/stow/) to symlink all files and directories to their correct location.

```bash
# First, make a dry run in order to check
stow -nvt $HOME package...

# If nothing went wrong, install the files
stow -vt $HOME package...

# If there are existing files you want to overwrite with a symlink, you can
# adopt them and then reset the repo.
# - THE ORIGINAL DOTFILES WILL BE LOST
# - ANY UNCOMMITED CHANGES WILL BE LOST TOO

# If there is a conflict, and don't want to keep the old file, we can either
#  a) Delete it and then run stow
#  b) Adopt it, then restore the package (just make sure to stash any changes
#     you were working on before)
stow -vt $HOME --adopt package...
git restore -- package...
```
