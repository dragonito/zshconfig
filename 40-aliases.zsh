# 🎨 LS Replacement mit eza
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --color=auto'
  alias ll='eza -lah --group-directories-first --color=auto'
  alias l='eza -la --icons --git --group-directories-first --color=auto'
else
  alias ll='ls -lah'
  alias l='ls -la'
fi

alias pad='open -a "ItsyPad"'

# ✍️ Dev Shortcuts
alias vim='nvim'

alias ..='command cd ..'
alias git-delete-merged-branches='git checkout main && git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias git-show-unrebased-branches='{ git br --contains main; git br; } | sort | uniq -u'
alias git-log='git log --name-status'
