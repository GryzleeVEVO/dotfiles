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

Packages are meant to be as modular as possible.

Dotfiles for specific applications are grouped by name.

Other packages include:

- `autostart`
  - Contains desktop files that are run by the DE (or the WM when using something like `dex`)
- `core`
  - Contains profile and files common to all shells
- `scripts`
  - Programs and scripts available for the user
- `theme`
  - All theme configs in one place

**TO DO**

- Move XDG desktop portal file to core?

## Theme and Look and feel

Since the config is not yet well defined, this section won't go into detail.

Currently it contains configs for:

- Xresources
  - Sets DPI
  - Sets up colours for apps using xrdb
- GTK
  - Currently using Adwaita (default theme)
  - GTK2 and GTK3 apps are configured with a settings file
  - GTK4 apps either work in a similar manner to GTK3 or...
  - use libadwaita, which is hard to customize
      - Dark theme can be set by `gsettings set org.gnome.desktop.interface color-scheme prefer-dark`
      - TODO: add it to profile so that it is set automatically?
      - It may also need to have the GTK [XDG Desktop Portal](https://wiki.archlinux.org/title/XDG_Desktop_Portal) set, since it implements a settings portal for settings read from DBus (i think)
      - A desktop portal is currently included in the i3 package
- Qt
  - It's a mess outside Plasma. A separate QPA is required.
  - qt6ct does that, but it is inconsistent:
    - KDE apps don't always work. `qt6ct-kde` has patches for KDE apps but YMMV.
    - Other apps have problems too, like icons not being properly set when using dark mode
  - Further research required
- Dircolors
  - Sets colours for ls.
  - Sourced from shell rc
- Icons
  - Currently using [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) (`papirus-icon-theme`)
  - Set by toolkit
- Cursor
  - Currently using [Capitaine cursors](https://github.com/keeferrourke/capitaine-cursors) (`capitaine-cursors`)
  - Set in multiple places
    - `.xresources`
    - `.local/share/icons`
    - By each toolkit

**TO DO**:

- Add theme-specific shell script sourced by profile?
- Move shell prompts too?
- And theme config for other apps?
- Unified look for GTK and Qt
