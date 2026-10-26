### Dateien & Navigation

# 🎨 LS Replacement mit eza
if command -v eza >/dev/null 2>&1; then
  ## ls via eza, Ordner zuerst
  alias ls='eza --group-directories-first --color=auto'
  ## Lange Liste inkl. versteckter Dateien
  alias ll='eza -lah --group-directories-first --color=auto'
  ## Lange Liste mit Icons und Git-Status
  alias l='eza -la --icons --git --group-directories-first --color=auto'
else
  alias ll='ls -lah'
  alias l='ls -la'
fi

## Datei/Text in ItsyPad öffnen
alias pad='open -a "ItsyPad"'
## Datei in ItsyPad öffnen (wie pad)
alias edit='pad'

### Dev Shortcuts

## vim startet Neovim
alias vim='nvim'

## Ein Verzeichnis hoch
alias ..='command cd ..'
