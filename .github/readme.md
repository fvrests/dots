# Dots

## Setup

Info on setting up a barerepo for the first time:

> [postylem/dotfiles](https://github.com/postylem/dotfiles-ARCHIVE)

## Installation

Clone to a temp directory.

```sh
git clone --separate-git-dir=$HOME/dots.git \
  https://github.com/fvrests/dots.git \
  dots-tmp
```

Copy working tree snapshot from the temp directory to the home directory, then delete the temp directory.

```sh
rsync --recursive --verbose --exclude '.git' dots-tmp/ $HOME/
rm -rf dots-tmp
```

## System preferences

| Setting                                               | Value     |
| ----------------------------------------------------- | --------- |
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
