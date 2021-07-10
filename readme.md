# ✨ 🌛 🌞 dots 🌞 🌜 ✨

a mystical quest to set up your dev machine

this script was created to automate setup of a fresh install of macOS with my own preferences. the vague fantasy quest theme is for our collective enjoyment.

## ✨ download

```sh
curl -LJO https://raw.githubusercontent.com/fvrests/dots/master/dots.sh && sh ./dots.sh
```

## 🌛 git setup

this script accepts custom git config/ssh keys.

```sh
sh dots.sh [-u USER] [-e EMAIL]
```

## 🌞 modified files

```
.zshrc
.config
└── com.googlecode.iterm2.plist
└── fish
    ├── config.fish
    ├── fishfile
    └── fish_variables
Library
├── Fonts
└── Application Support
    └── Code - Insiders
        └── User
            └── settings.json
```

## 🌜 system preferences

| Setting                                 | Value |
| --------------------------------------- | ----- |
| **Global**                              |       |
| Accent color                            | pink  |
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
| **Menubar**                             |       |
| Show battery percentage                 | true  |

## ✨ manual settings

- Before running, sign in to Mac app store
- Preferences > Keyboard > Modifier Keys > Map caps lock to escape
- Preferences > Displays > Night Shift > Schedule: Sunset to Sunrise
- Preferences > Privacy > Full Disk Access > Allow Terminal.app\* \* _Needed for zapping brew casks and other privileged tasks_
- Code - Insiders > Extensions > Disable default color schemes
- Code - Insiders > Sign in to Settings Sync
- install Cartograph font
- add ssh key from clipboard to github's ssh key settings

Inspired by [mvllow/dots](https://github.com/mvllow/dots)
