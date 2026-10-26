### Git

# Default-Branch des Remotes ermitteln (origin/main, origin/master, ...)
_git_base() {
  git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null || echo origin/main
}

# Liste anzeigen, bestätigen, mit -D löschen
_git_confirm_delete() {
  local -a branches=("$@")
  if (( ! $#branches )); then
    echo "Nichts zu löschen."
    return 0
  fi
  print -l -- "${branches[@]}"
  if ! read -q "?${#branches} Branch(es) löschen? [y/N] "; then
    echo
    return 1
  fi
  echo
  git branch -D -- "${branches[@]}"
}

## Lokale Branches anzeigen, deren Remote-Branch gelöscht wurde
git-gone() {
  git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads \
    | awk '$2 == "[gone]" {print $1}'
}

## Lokale Branches löschen, deren Remote-Branch gelöscht wurde (mit Rückfrage)
git-delete-gone-branches() {
  git fetch --prune --quiet || return
  _git_confirm_delete ${(f)"$(git-gone)"}
}

## In [base] gemergte Branches löschen (Default: origin/HEAD, mit Rückfrage)
git-delete-merged-branches() {
  local base=${1:-$(_git_base)}
  git fetch --prune --quiet || return
  _git_confirm_delete ${(f)"$(
    git for-each-ref --merged "$base" --format='%(refname:short)' refs/heads \
      | grep -vE '^(main|master|develop|release/.*)$'
  )"}
}

## Branches, die nicht auf [base] rebased sind (ahead/behind)
git-show-unrebased-branches() {
  local base=${1:-$(_git_base)} b counts
  for b in ${(f)"$(git for-each-ref --no-contains "$base" --format='%(refname:short)' refs/heads)"}; do
    counts=$(git rev-list --left-right --count "$b...$base")
    printf '%-40s ahead %3s  behind %3s\n' "$b" ${=counts}
  done
}

## Git-Log mit geänderten Dateien
alias git-log='git log --name-status'
