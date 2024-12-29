```
                   __    _  _____ ____ __ __   ___   ___
                  /  \ ,' \/_  _// __// // /  / _/ ,' _/
                 / o |/ o | / / / _/ / // /_ / _/ _\ `.
                /__,' |_,' /_/ /_/  /_//___//___//___,'
```
# Install

[GNU Stow](https://www.gnu.org/software/stow/) is used to manage the symlinks from the repository.

```bash
# Dry run
stow -nvt $HOME package ...

# If everything OK, apply
stow -vt $HOME package ...

# If there are existing files you want to overwrite with a symlink, you can
# adopt them and then reset the repo.
# - THE ORIGINAL DOTFILES WILL BE LOST
# - ANY UNCOMMITED CHANGES WILL BE LOST TOO
stow -vt $HOME --adopt package ...
git reset --hard HEAD
```

# Packages

The main packages are:

- **core**: All files needed for a basic non-graphical environment. It includes a basic shell profile and environment, aliases, useful scripts and config files for tools and CLI/TUI-based programs.
- **desktop**: Configured **i3** desktop tailored for my laptop, including theme, status bar, notifications daemon, autostart, etc...
- **bash** and **zsh**: Kept separate in case one is not available. They contain their respective rc's.
- **neovim**: Big enough to have its own package. Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as a plugin manager.
