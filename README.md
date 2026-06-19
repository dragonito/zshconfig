# ZSH Config

My personal ZSH and terminal configuration for macOS.

This repository contains my shell setup, aliases, completions, prompt configuration and terminal customizations that I use daily for software development.

## Features

- ZSH as primary shell
- Starship prompt with Tokyo Night styling
- Homebrew integration
- Homebrew completion support
- Git-aware prompt
- Docker-aware prompt
- PHP, Python, Go and Rust project detection
- zoxide integration
- eza integration
- ripgrep-based workflows
- WezTerm terminal configuration
- Nerd Font support (Monaspace Argon)

The setup is optimized for a modern development workflow focused on:

- PHP / Symfony
- JavaScript / Node.js
- Docker / OrbStack
- Neovim
- macOS

## Screenshot

_Add a screenshot here._

## Requirements

### macOS

The configuration is primarily developed and tested on macOS.

### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Recommended packages

```bash
brew install zsh starship eza zoxide ripgrep fd fzf
```

### Fonts

- Monaspace Argon
- Symbols Nerd Font

## Installation

```bash
git clone https://github.com/dragonito/zshconfig.git ~/dotfiles/zshconfig
```

```bash
ln -sf ~/dotfiles/zshconfig/.zshrc ~/.zshrc
```

## Included Components

### ZSH

- aliases
- environment variables
- completion configuration
- shell helpers
- development utilities

### Starship

Custom Tokyo Night inspired prompt with:

- current directory
- git branch
- git status
- PHP projects
- Python projects
- Go projects
- Rust projects
- Docker projects
- command duration
- exit status indicator

### WezTerm

- Tokyo Night theme
- Monaspace Argon
- Nerd Font fallbacks
- custom pane shortcuts
- fzf-based file opener
- macOS-specific keyboard handling

## Philosophy

This configuration intentionally focuses on:

- speed
- readability
- developer productivity

The goal is to expose useful information while keeping the prompt responsive and visually clean.

## License

Feel free to use parts of this configuration as inspiration for your own setup.
