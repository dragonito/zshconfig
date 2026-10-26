### Navigation (zoxide)

# Zoxide: smarter directory jumping (keep builtin cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  ## Zum häufig genutzten Verzeichnis springen: z <teil>
  # (Hinweis: überschreibt zoxides interaktives zi)
  alias zi='z'
  ## Zurück ins vorherige Verzeichnis
  alias zz='z -'
fi


### Suche (fzf, fd, rg)

# fzf: Ctrl-R (History), Ctrl-T (Datei einfügen), Alt-C (cd), **<Tab> (Fuzzy-Completion)
if command -v fzf >/dev/null 2>&1; then
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
    _fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
    _fzf_compgen_dir()  { fd --type d --hidden --exclude .git . "$1"; }
  fi
  command -v eza >/dev/null 2>&1 && \
    export FZF_ALT_C_OPTS="--preview 'eza -T -L 2 --color=always {} | head -100'"
  source <(fzf --zsh)
fi
