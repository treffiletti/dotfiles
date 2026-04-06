function gcpu --description 'git add, commit, and push in one step'
    git add . && git commit -m $argv[1] && git push
end
