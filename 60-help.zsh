### Hilfe

# Verzeichnis dieser Config merken (beim Sourcen aufgelöst, folgt Symlinks)
typeset -g _ZHELP_DIR=${${(%):-%x}:A:h}

## Hilfe zu eigenen Aliases/Funktionen: zhelp [-a alle] [-i fzf] [filter]
zhelp() {
  local all=0 interactive=0 OPTIND opt
  while getopts "ai" opt; do
    case $opt in
      a) all=1 ;;
      i) interactive=1 ;;
      *) print -u2 "Usage: zhelp [-a] [-i] [filter]"; return 2 ;;
    esac
  done
  shift $((OPTIND - 1))

  local out
  out=$(awk -v filter="${1:-}" -v all=$all '
    FNR == 1 {
      group = FILENAME; sub(/.*\//, "", group); sub(/\.zsh$/, "", group); sub(/^[0-9]+-/, "", group)
      desc = ""
    }
    { line = $0; sub(/^[ \t]+/, "", line) }
    line ~ /^### / { group = substr(line, 5); next }
    line ~ /^## /  { desc = substr(line, 4); next }
    line ~ /^alias [^=]+=/ || line ~ /^(function )?[A-Za-z0-9_.:-]+ *\(\) *\{/ || line ~ /^function [A-Za-z0-9_.:-]+/ {
      name = line
      sub(/^alias /, "", name); sub(/^function /, "", name); sub(/[=( ].*/, "", name)
      if (name ~ /^_/ || seen[name]++ || (!all && desc == "")) { desc = ""; next }
      hay = tolower(name " " desc " " group)
      if (filter == "" || index(hay, tolower(filter))) {
        if (group != last) { printf "\n\033[1;34m%s\033[0m\n", group; last = group }
        printf "  \033[1m%-30s\033[0m %s\n", name, desc
      }
      desc = ""; next
    }
    line !~ /^#/ { desc = "" }
  ' "$_ZHELP_DIR"/*.zsh(N))

  if (( interactive )) && (( $+commands[fzf] )); then
    local pick
    pick=$(print -r -- "$out" | grep -E '^  ' | fzf --ansi --prompt='zhelp> ') || return
    pick=${${(z)pick}[1]}
    print -z -- "${pick//$'\e'\[[0-9;]#m/}"
  else
    print -r -- "$out"
    echo
  fi
}
