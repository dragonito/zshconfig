### Tipps & Cheatsheet

typeset -g _ZTIPS_FILE=${${(%):-%x}:A:h}/tips.txt
# ZTIP_MODE: daily (Default, 1 Tipp pro Tag beim Shell-Start) | always | off
: ${ZTIP_MODE:=daily}

# Tipps für installierte Tools, optional gefiltert; Ausgabe: tool<TAB>befehl<TAB>beschreibung
_ztips() {
  [[ -r $_ZTIPS_FILE ]] || return 1
  local -a installed
  local t
  for t in ${(u)${(f)"$(awk -F' :: ' '!/^[ \t]*(#|$)/ {gsub(/ /,"",$1); print $1}' "$_ZTIPS_FILE")"}}; do
    [[ $t == zsh ]] || (( $+commands[$t] )) || [[ $t == git ]] && installed+=($t)
  done
  awk -F' :: ' -v tools=" ${installed[*]} " -v filter="${1:l}" '
    /^[ \t]*(#|$)/ { next }
    {
      for (i = 1; i <= 3; i++) { gsub(/^[ \t]+|[ \t]+$/, "", $i) }
      if (index(tools, " " $1 " ") == 0) next
      if (filter != "" && !index(tolower($1 " " $2 " " $3), filter)) next
      print $1 "\t" $2 "\t" $3
    }' "$_ZTIPS_FILE"
}

## Zufälliger Tipp zu deinen Tools: ztip [filter]
ztip() {
  local -a lines=(${(f)"$(_ztips "$1")"})
  (( $#lines )) || { echo "Keine Tipps gefunden."; return 1 }
  local -a f=("${(@ps:\t:)lines[RANDOM % $#lines + 1]}")
  printf '\033[2m💡 %s:\033[0m \033[1;33m%s\033[0m \033[2m– %s\033[0m\n' "$f[1]" "$f[2]" "$f[3]"
}

## Cheatsheet aller Tool-Tipps: zcheat [-i fzf] [filter]
zcheat() {
  local interactive=0
  [[ $1 == -i ]] && { interactive=1; shift }
  local out
  out=$(_ztips "$1" | awk -F'\t' '
    $1 != last { printf "\n\033[1;34m%s\033[0m\n", $1; last = $1 }
    { printf "  \033[1;33m%-34s\033[0m %s\n", $2, $3 }')
  [[ -n $out ]] || { echo "Keine Tipps gefunden."; return 1 }
  if (( interactive )) && (( $+commands[fzf] )); then
    local pick
    pick=$(_ztips "$1" | fzf --delimiter='\t' --with-nth=1,2,3 --prompt='zcheat> ') || return
    pick=${${(ps:\t:)pick}[2]}
    # Tastenkürzel (Ctrl-R, **<Tab> ...) nur anzeigen, echte Befehle in die Kommandozeile legen
    if [[ $pick == (Ctrl|Alt|Esc)* || $pick == *'<'* ]]; then print -r -- "$pick"; else print -z -- "$pick"; fi
  else
    print -r -- "$out"; echo
  fi
}

# Tipp beim Start einer interaktiven Shell
if [[ -o interactive && $ZTIP_MODE != off ]]; then
  () {
    if [[ $ZTIP_MODE == daily ]]; then
      local stamp=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/ztip-day today=${(%):-%D{%F}}
      [[ -r $stamp && $(<$stamp) == $today ]] && return
      mkdir -p ${stamp:h} && print -r -- $today >| $stamp
    fi
    ztip
  }
fi
