# Dots

## Setup

Info on setting up a barerepo for the first time:

> [postylem/dotfiles](https://github.com/postylem/dotfiles)

## Download

```sh
curl -LJO https://raw.githubusercontent.com/fvrests/dots/main/.config/dots/dots.sh && sh ./dots.sh
```

## Manual installation

> Log in to Mac app store before run - allows homebrew to install `mas` apps

Clone to a temp directory.

```sh
git clone \
  --separate-git-dir=$HOME/dots.git \
  https://github.com/fvrests/dots.git \
  dots-tmp
```

Copy working tree snapshot from the temp directory to the home directory, then delete the temp directory.

```sh
rsync --recursive --verbose --exclude '.git' dots-tmp/ $HOME/
rm -rf dots-tmp
```

Optionally, add an alias to manage your dots directly.

```sh
alias .git='git --git-dir=$HOME/dots.git/ --work-tree=$HOME'
```

## System preferences

| Setting                                               | Value     |
| ----------------------------------------------------- | --------- |
| **Global**                                            |           |
| Accent color                                          | pink      |
| Highlight color                                       | purple    |
| **Dock**                                              |           |
| Autohide                                              | true      |
| Show recent apps                                      | false     |
| Set docked apps                                       | none      |
| Show only active apps                                 | true      |
| Order spaces by recent use                            | false     |
| **Keyboard**                                          |           |
| Auto correct                                          | false     |
| Auto capitalize                                       | false     |
| Use smart quotes/dashes                               | false     |
| Enable press-and-hold (blocks system-wide key repeat) | false     |
| Shorten delay before key repeat                       | 15        |
| Increase key repeat speed                             | 2         |
| **Menubar**                                           |           |
| Autohide                                              | true      |
| Show Siri                                             | false     |
| **Screencapture**                                     |           |
| Default save location                                 | Downloads |
| Disable shadow                                        | true      |
| **Trackpad**                                          |           |
| Tap to click                                          | true      |
| Increase tracking speed                               | 3         |
| **Finder**                                            |           |
| Warn on file extension change                         | false     |
| Warn on emptying trash                                | false     |

Inspired by [mvllow/dots](https://github.com/mvllow/dots)
