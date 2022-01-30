# dots

**setting up barerepo for the first time**

> [postylem/dotfiles](https://github.com/postylem/dotfiles)

## download

```sh
curl -LJO https://raw.githubusercontent.com/fvrests/dots/main/.config/dots/dots.sh && sh ./dots.sh
```

## manual installation

Clone to a temp directory

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

## system preferences

| Setting                                 | Value |
| --------------------------------------- | ----- |
| **Global**                              |       |
| Accent color pink                       |
| Highlight color                         | pink  |
| **Dock**                                |       |
| Autohide                                | true  |
| Show recent apps                        | false |
| Show only active apps                   | true  |
| **Keyboard**                            |       |
| Auto correct                            | false |
| Auto capitalize                         | false |
| Use smart quotes/dashes                 | false |
| Enable system-wide key repeat           | true  |
| Enable faster key repeat                | 2     |
| Enabled shorter delay before key repeat | 10    |
| **Trackpad**                            |       |
| Tap to click                            | true  |
| Increase tracking speed                 | 3     |
| **Finder**                              |       |
| Warn on file extension change           | false |
| Warn on emptying trash                  | false |
| Show battery percentage                 | true  |

## manual settings

- Before running, sign in to Mac app store
- Preferences > Keyboard > Modifier Keys > Map caps lock to escape
- Preferences > Displays > Night Shift > Schedule: Sunset to Sunrise
- Preferences > Privacy > Full Disk Access > Allow Terminal.app\* \* _Needed for zapping brew casks and other privileged tasks_
- Code - Insiders > Extensions > Disable default color schemes
- install Cartograph font
- add ssh key from clipboard to github's ssh key settings

Inspired by [mvllow/dots](https://github.com/mvllow/dots)
