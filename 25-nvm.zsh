# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"

# Lazy-load nvm only when needed
_nvm_lazy_load() {
  unset -f node npm npx nvm 2>/dev/null || true
  [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
}

nvm() { _nvm_lazy_load; nvm "$@"; }
node() { _nvm_lazy_load; node "$@"; }
npm()  { _nvm_lazy_load; npm "$@"; }
npx()  { _nvm_lazy_load; npx "$@"; }