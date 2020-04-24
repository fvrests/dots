# ✨ 🌛 🌞 dots 🌞 🌜 ✨

a mystical quest to set up your dev machine

this script was created to automate setup of a fresh install of macOS with my own preferences. the vague fantasy quest theme is for our collective enjoyment.

## ✨ download

```sh
curl -LJO https://raw.githubusercontent.com/fvrests/dots/master/dots.sh
```

## 🌛 git setup

this script accepts custom git config/ssh keys.

```sh
sh dots.sh [-u USER] [-e EMAIL]
```

## 🌞 modified files

```
.zshrc
.hyper.js
.config
└── fish
    ├── config.fish
    └── fishfile
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

- Preferences > Keyboard > Modifier Keys > Map caps lock to escape
- Preferences > Displays > Night Shift > Schedule: Sunset to Sunrise
- Preferences > Privacy > Full Disk Access > Allow Terminal.app\* \* _Needed for zapping brew casks and other priviledged tasks_
- Install Dank Mono font
- Code - Insiders > Configure Runtime Arguments: `"disable-hardware-acceleration": true`

Inspired by [mvllow/dots](https://github.com/mvllow/dots)
