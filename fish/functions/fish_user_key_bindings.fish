# Custom key bindings (called by Fish after plugin bindings are set)
function fish_user_key_bindings
    bind \e/ _ai_explain   # Alt-/ : explain current/last command via sgpt
    bind \cg _ai_suggest   # Ctrl-G: suggest a command from natural language via sgpt
end
