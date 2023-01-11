# dotfiles

Home, sweet $HOME.

## Concept

The idea is to preserve configuration files in a local git repo and symlink them to corresponding places in your home
directory.  Keeping track of changes is the same as using any other git repo. Install script creates symlinks only in
places where config files don't exist already.

## Installation

Clone this repo, e.g. to `~/.dotfiles`. Invoke:

```sh
elvish install.elv PRESET TARGET
```

Where PRESET is one of those defined in config.yml, e.g. `linux`, or `darwin`.

Typically TARGET is your home directory. If you are not familiar with this script, you can specify some temporary
directory instead and see how the script works.

Note that script can be called from any directory.

## Configuration

Configuration files can be grouped in *layers*. Each layer have corresponding directory in the repo (see: `unix` and
`darwin`). `install.elv` knows which files you want to symlink by specifying a *preset*. Each preset is composed of
one or multiple layers. Layers can be reused in multiple presets. Mapping is defined in `config.yml`.

## Usage

- Whenever you want your configuration file to be version controlled, copy it to the repo, remove it from the filesystem
and run `install.elv` which will create symlink.
- Whenever you want to preserve you configuration file unaffected by `install.elv`, simply leave it in the file system
as it is. It will stay untouched regardles of the fact if it is in the repo or not.
- Whenever you want to remove configuration file, remove it from git repo and remove symlink from the file system.

## Requirements

For install script:

- elvish >= 0.18
- jq >= 1.6
- core utils: ln, cp
