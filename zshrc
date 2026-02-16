# ~/.zshrc — interactive shell only
[[ -o interactive ]] || return

ZSHCONF_DIR="${HOME}/.zshrc.d"

if [[ -d "$ZSHCONF_DIR" ]]; then
  for f in "$ZSHCONF_DIR"/*.zsh(N); do
    source "$f"
  done
fi

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

. "$HOME/.local/bin/env"
