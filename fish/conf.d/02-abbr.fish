# Abbreviations (expand inline - equivalent to zsh aliases)
# Use `abbr` instead of `alias` in Fish for transparency

# Shell config
abbr -a fc 'code ~/.config/fish/config.fish'
abbr -a rel 'source ~/.config/fish/config.fish'

# Navigation
abbr -a desk 'cd ~/Desktop'
abbr -a dl 'cd ~/Downloads'
abbr -a sites 'cd ~/Sites'

# Git
abbr -a gig 'code .gitignore'

# npm
abbr -a npmrs 'npm run start'
abbr -a npmrsl 'npm run start:localhost'
abbr -a npmrd 'npm run dev'
abbr -a npmrsd 'npm run start:dev'
abbr -a npmrw 'npm run watch'
abbr -a npmrdb 'npm run debug'
abbr -a nirs 'npm install && npm run start'

# pnpm
abbr -a pdev 'pnpm run dev'

# Node bin shortcuts
abbr -a ngend './node_modules/.bin/ngen'
abbr -a nxbin './node_modules/.bin/nx'

# Utilities
abbr -a dsrem 'find . -name \'.DS_Store\' -type f -delete'
abbr -a konkprox 'konkat policies && konkat proxies && konkat resources && konkat targets'

# AI tools
abbr -a chat-search 'chatgpt-history search'
abbr -a chat-canvas 'chatgpt-history canvas'

# Chrome debug
abbr -a chromedebug 'cd ~/Sites && /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 > nohup.out'
