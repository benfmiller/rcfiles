# rcfiles

Ubuntu: oh-my-zsh, tmux, neovim (using telescope and nvim-lsp), and i3

Mac: skhd and yabai

Windows: wsl-ubuntu and git-bash

Depending on the code, I'll use vscode. The vscode_shell script lets vscode use a tmux session as the terminal.

Some of the files are my setup specific or they are rarely used. Some of it is not used at all
but helps me make sense of things, so not everything is important.

**If you have questions, please create an issue or send me an email! I'd be glad to help.**

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

zsh_user.sh is for all user config

sourcers in subdirectories are meant to be in the home directory with the proper name per file
