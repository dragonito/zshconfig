# 🧪 Tools & Enhancements

# Zoxide: smarter directory jumping (keep builtin cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias zi='z'
  alias zz='z -'
fi

