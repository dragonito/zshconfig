### Homebrew / Brewfile

# Brewfile liegt im Config-Repo; brew bundle nutzt HOMEBREW_BUNDLE_FILE automatisch
typeset -g BREWFILE=${${(%):-%x}:A:h}/Brewfile
export HOMEBREW_BUNDLE_FILE=$BREWFILE

## Fehlende Pakete aus dem Brewfile installieren (ohne Upgrades)
brew-sync() {
  brew bundle install --no-upgrade --file="$BREWFILE" "$@" || return
  : >| ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/brew-missing 2>/dev/null
}

## Zeigt, was aus dem Brewfile noch fehlt
brew-check() {
  brew bundle check --no-upgrade --verbose --file="$BREWFILE"
}

## Zeigt installierte Pakete, die nicht im Brewfile stehen (rein lesend)
# ACHTUNG: niemals "brew bundle cleanup" verwenden – das deinstalliert nach Rückfrage wirklich!
brew-unlisted() {
  print -P "%BFormulae (installiert, nicht im Brewfile):%b"
  comm -23 <(brew leaves --installed-on-request | sort) \
           <(brew bundle list --formula --file="$BREWFILE" | sort)
  print -P "\n%BCasks (installiert, nicht im Brewfile):%b"
  comm -23 <(brew list --cask -1 | sort) \
           <(brew bundle list --cask --file="$BREWFILE" | sort)
}

## Paket installieren und ins Brewfile eintragen: brew-add [--cask] <name>…
brew-add() {
  local type=brew p
  [[ $1 == --cask ]] && { type=cask; shift }
  (( $# )) || { print -u2 "Usage: brew-add [--cask] <name>…"; return 2 }
  brew install ${${(M)type:#cask}:+--cask} "$@" || return
  for p in "$@"; do
    if grep -qF -- "$type \"$p\"" "$BREWFILE" 2>/dev/null; then
      echo "· $p steht schon im Brewfile"
    else
      print -r -- "$type \"$p\"" >> "$BREWFILE"
      echo "+ $p ins Brewfile eingetragen"
    fi
  done
  echo "→ Commit nicht vergessen (zshconfig)."
}

## Paket deinstallieren und aus dem Brewfile entfernen: brew-rm <name>…
brew-rm() {
  (( $# )) || { print -u2 "Usage: brew-rm <name>…"; return 2 }
  brew uninstall "$@" || return
  local -a lines=("${(@f)"$(<$BREWFILE)"}")
  local p
  for p in "$@"; do
    lines=("${(@)lines:#(brew|cask) \"${(b)p}\"*}")
  done
  print -rl -- "${lines[@]}" >| "$BREWFILE"
  echo "- aus dem Brewfile entfernt. Commit nicht vergessen."
}

# Beim Shell-Start: Ergebnis des letzten Checks anzeigen (sofort, aus dem Cache)
# und den Check höchstens 1x/Tag bzw. nach Brewfile-Änderung im Hintergrund erneuern.
if [[ -o interactive && -r $BREWFILE ]] && (( $+commands[brew] )); then
  () {
    local cache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/brew-missing
    local -a stale=($cache(N.mh+24))
    if [[ -s $cache ]]; then
      print -P "%F{yellow}⚠ ${$(wc -l < $cache)// /} Paket(e) aus dem Brewfile fehlen → brew-check / brew-sync%f"
    fi
    if [[ ! -e $cache || $BREWFILE -nt $cache ]] || (( $#stale )); then
      mkdir -p ${cache:h}
      { brew bundle check --no-upgrade --verbose --file="$BREWFILE" 2>/dev/null \
          | grep '^→' >| $cache.tmp; mv -f $cache.tmp $cache } &!
    fi
  }
fi
