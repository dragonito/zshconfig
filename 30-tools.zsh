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

