# Homebrew completions
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
  fpath=(${fpath:#/opt/homebrew/share/zsh/site-functions})
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
mkdir -p ~/.cache/zsh
compinit -d ~/.cache/zsh/zcompdump
