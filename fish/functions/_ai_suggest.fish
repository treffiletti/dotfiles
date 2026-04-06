function _ai_suggest --description 'Suggest a shell command from natural language via sgpt (bound to Ctrl-G)'
    if not command -q sgpt
        commandline -f repaint
        return
    end

    set -l ask (commandline)
    if test -z "$ask"
        read -l -P "Describe the command you want: " ask
        or begin
            commandline -f repaint
            return
        end
    end

    set -l out (SGPT_NO_EDITOR=1 sgpt --shell --no-interaction $ask 2>/dev/null)

    if test -n "$out"
        commandline -r $out
    end
    commandline -f repaint
end
