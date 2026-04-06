function _ai_explain --description 'Explain current or last command via sgpt (bound to Alt-/)'
    if not command -q sgpt
        commandline -f repaint
        return
    end

    set -l cmd (commandline)
    if test -z "$cmd"
        set cmd (history | head -1)
    end
    if test -z "$cmd"
        commandline -f repaint
        return
    end

    echo ""
    sgpt --explain -- $cmd | less -R
    commandline -f repaint
end
