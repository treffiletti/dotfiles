# .zshrc - Zsh config (legacy - primary shell is now Fish)
# Kept for SSH sessions or environments without Fish

# Load secrets
[[ -f "$HOME/dotfiles/.env.local" ]] && source "$HOME/dotfiles/.env.local"

# Preferred editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

# Compilation flags
export ARCHFLAGS="-arch arm64"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
