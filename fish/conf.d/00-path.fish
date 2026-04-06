# PATH setup - Homebrew, pyenv, nvm

# Homebrew
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# pyenv
if command -q pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - | source
end

# nvm (via nvm.fish plugin - installs to ~/.local/share/nvm)
# Run `nvm install lts` after first login to install Node
