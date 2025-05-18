```
    __    _  _____ ____ __ __   ___   ___
   /  \ ,' \/_  _// __// // /  / _/ ,' _/
  / o |/ o | / / / _/ / // /_ / _/ _\ `.
 /__,' |_,' /_/ /_/  /_//___//___//___,'
```

# Gryzlee's spectacularly unimpressive dotfiles

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

This repository also includes a `user_configuration.json` for [archinstall](https://github.com/archlinux/archinstall) in order to speed up reinstalling the system.

## Packages

The dotfiles are grouped into packages:

- **core**: The bare minimum I'd want on any system: a **`.profile`** with the right environment, **shell aliases**, and configuration for CLI and TUI programs, like **tmux**.
- **desktop**: Anything common to any desktop, mostly autostart and GUI programs.
- **bash** and **zsh**: Configurations for each shell.
- **neovim**: My Neovim config. Complex enough to have its own [README](./neovim/.config/nvim/README.md).

Aditionally, an **etc** directory is included, however it will be ignored by stow since etc files must be handled manually.

## To do list

- [ ] Finnaly fix the zsh config.
- [ ] De-merge i3 from the desktop package.
- [ ] Make an install script for etc files, including scripts to modify files that, due to security reasons, cannot be commited into a VCS.
