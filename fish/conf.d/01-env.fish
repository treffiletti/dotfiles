# Environment variables + secrets

# Editor
if set -q SSH_CONNECTION
    set -gx EDITOR vim
else
    set -gx EDITOR code
end

# Compilation flags
set -gx ARCHFLAGS "-arch arm64"

# Load secrets via bass (bass allows sourcing bash export syntax files)
if command -q bass
    if test -f $HOME/dotfiles/.env.local
        bass source $HOME/dotfiles/.env.local
    end
end

# Note: Graphite (gt) does not support Fish completions
