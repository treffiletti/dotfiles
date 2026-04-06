function claude --description 'Run claude CLI, prepending .ai/claude.md context if present'
    if test -f .ai/claude.md
        set -l prefix (cat .ai/claude.md)
        command claude "$prefix

USER REQUEST:
$argv"
    else
        command claude $argv
    end
end
