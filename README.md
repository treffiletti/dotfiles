# Dotfiles

Personal dotfiles for zsh, git, and development tools.

## What's Included

- **Shell Configuration**: `.zshrc`, `.zprofile`, `.zlogin`
- **Custom Dotfiles**: `.aliases`, `.functions`, `.env`
- **Powerlevel10k Theme**: `.p10k.zsh`
- **Git Configuration**: `.gitconfig`, `.gitignore_global`
- **Graphite Completions**: `.gt-completion`

## Quick Start

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
   ```

2. Create your secrets file:
   ```bash
   cp ~/dotfiles/.env.local.example ~/dotfiles/.env.local
   # Edit .env.local with your actual API keys and credentials
   ```

3. Run the install script:
   ```bash
   cd ~/dotfiles
   ./install.sh
   ```

The install script will:
- Backup your existing dotfiles to `~/dotfiles_backup_TIMESTAMP`
- Create symlinks from your home directory to files in `~/dotfiles`
- Preserve your secrets in `.env.local` (not tracked by git)

### Manual Installation

If you prefer to manually symlink files:

```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
# ... and so on
```

## Structure

```
dotfiles/
├── .aliases          # Shell aliases
├── .env              # Environment variables (no secrets!)
├── .env.local        # Secrets (git-ignored, create from .env.local.example)
├── .env.local.example # Template for secrets
├── .functions        # Shell functions
├── .gitconfig        # Git configuration
├── .gitignore        # Dotfiles repo gitignore
├── .gitignore_global # Global gitignore for all projects
├── .gt-completion    # Graphite CLI completions
├── .p10k.zsh         # Powerlevel10k theme config
├── .zlogin           # Zsh login script
├── .zprofile         # Zsh profile
├── .zshrc            # Main zsh configuration
├── install.sh        # Installation script
└── README.md         # This file
```

## Prerequisites

- **Zsh**: Shell
- **Oh My Zsh**: Framework (`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`)
- **Powerlevel10k**: Theme (installed via Oh My Zsh)
- **Homebrew**: Package manager (macOS)
- **Node.js**: Via nvm
- **Python**: Via pyenv

## Features

### Aliases

- **Navigation**: `desk`, `dl`, `sites`
- **NPM shortcuts**: `npmrs`, `npmrsd`, `npmrd`, `pdev`
- **Utilities**: `dsrem` (remove .DS_Store files), `chromedebug`, `konkprox`
- **AI helpers**: `chat-search`, `chat-canvas`

### Functions

- **`gcpu <message>`**: Git add, commit, and push in one command
- **`claude [args]`**: Enhanced Claude CLI with `.ai/claude.md` context support
- **`konkat <path>`**: Concatenate code files from a directory
- **`ai <query>`**: OpenAI-powered command suggestions (Ctrl+G)
- **`ai-anthropic <query>`**: Claude-powered command suggestions
- **ShellGPT**: AI command explanation (Alt+/) and suggestions

### Environment

- **Java**: Java 21 configured
- **PNPM**: Package manager path
- **Custom PATH**: Includes homebrew, dotfiles, bin directories
- **ZSH**: Colorful syntax highlighting

## Security

**IMPORTANT**: Never commit secrets to git!

- All API keys and credentials belong in `.env.local`
- `.env.local` is git-ignored
- `.env` contains only non-sensitive environment variables
- Use `.env.local.example` as a template

## Customization

### Adding Secrets

Edit `~/dotfiles/.env.local` (create from `.env.local.example`):

```bash
export NPM_TOKEN="your_token"
export OPENAI_API_KEY="your_key"
# etc.
```

### Adding Aliases

Edit `~/dotfiles/.aliases`:

```bash
alias myalias="my command"
```

Then reload: `source ~/.zshrc` or just `rel`

### Adding Functions

Edit `~/dotfiles/.functions` and add your custom shell functions.

## Updating

Pull latest changes:

```bash
cd ~/dotfiles
git pull
source ~/.zshrc
```

## Uninstall

1. Remove symlinks and restore backups:
   ```bash
   rm ~/.zshrc ~/.gitconfig  # etc.
   cp ~/dotfiles_backup_TIMESTAMP/.zshrc ~/ # restore from backup
   ```

2. Remove the dotfiles directory:
   ```bash
   rm -rf ~/dotfiles
   ```

## License

MIT - Feel free to use and modify for your own purposes.
