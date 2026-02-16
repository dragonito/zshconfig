# 🎨 LS Replacement mit eza
alias ls='eza --group-directories-first --color=auto'
alias ll='eza -lah --group-directories-first --color=auto'
alias l='eza -la --icons --git --group-directories-first --color=auto'

# ✍️ Dev Shortcuts
alias vim='nvim'

alias ..='command cd ..'
alias git-delete-merged-branches='git checkout master && git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias git-show-unrebased-branches='{ git br --contains master; git br; } | sort | uniq -u'
alias git-log='git log --name-status'
