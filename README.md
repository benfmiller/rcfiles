# rcfiles

This is my whole configuration setup. I use oh-my-zsh, tmux, and neovim. If I'm working on
larger projects, I like to use vscode from windows to connect through wsl or ssh. The vscode_shell
script lets vscode use a tmux session as the terminal. There is a good amount of compatibility and
configuration across systems, but is mostly setup for debian linux.

Some of the files are my setup specific or they are rarely used. Some of it is not used at all
but helps me make sense of things, so not everything is important.

## Deployment

clone this repo into your home directory, then run

```bash
~/rcfiles/deploy_install.sh
```
for the full setup

If you can't install anything/don't have root, run
```bash
~/rcfiles/deploy_no_install.sh
```

There will be errors as you reload your setup until everything is installed

The deploy scripts source from rcfiles, so just have to git pull to update to most recent configuration.

## Notes

zsh_zsh.sh is for zsh specific config
zsh_user.sh is for all user config

sourcers in subdirectories are meant to be in the home directory with the proper name per file
