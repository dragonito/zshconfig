# 🧪 Tools & Enhancements

# Zoxide: smarter cd
eval "$(zoxide init zsh)"
cd() { z "$@"; }
alias zi='z'
alias zz='z -'

# ZSH Syntax Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
