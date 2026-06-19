# Homebrew completions
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
  fpath=(${fpath:#/opt/homebrew/share/zsh/site-functions})
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
compinit -d ~/.cache/zsh/zcompdump
