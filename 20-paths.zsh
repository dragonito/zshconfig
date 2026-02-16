# Paths (zsh style)
typeset -U path PATH

# Windsurf / Codeium tools (only if present)
[[ -d "$HOME/.codeium/windsurf/bin" ]] && path=("$HOME/.codeium/windsurf/bin" $path)

export PATH