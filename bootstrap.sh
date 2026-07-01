#!/usr/bin/env bash
# Idempotent dotfiles installer. Safe to re-run.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Packages to symlink into $HOME. Edit this list to install selectively per machine.
PACKAGES=(zsh git vim ghostty p10k)

echo "==> Bootstrapping dotfiles from $DOTFILES_DIR"

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Dependencies
echo "==> Installing Brewfile dependencies"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# 3. Symlink packages.
#    --no-folding keeps ~/.config (and ~/.config/zsh, etc.) as REAL directories and symlinks
#    only the individual tracked files, so other tools can't write into the repo via ~/.config.
echo "==> Stowing packages: ${PACKAGES[*]}"
stow --no-folding --target="$HOME" --restow "${PACKAGES[@]}"

# 4. Seed gitignored personal files from their templates (only if missing).
seed() { # seed <example-src> <dest>
  if [[ ! -e "$2" ]]; then
    mkdir -p "$(dirname "$2")"
    cp "$1" "$2"
    echo "    created $2"
  fi
}
echo "==> Seeding personal files"
seed "$DOTFILES_DIR/zsh/.config/zsh/local.zsh.example"   "$HOME/.config/zsh/local.zsh"
seed "$DOTFILES_DIR/zsh/.config/zsh/secrets.zsh.example" "$HOME/.config/zsh/secrets.zsh"
seed "$DOTFILES_DIR/git/.gitconfig.local.example"        "$HOME/.gitconfig.local"

# 5. VSCode keybindings (only keybindings.json is shared — never settings.json).
#    Not a stow package because its path lives outside the $HOME dotfile layout.
VSCODE_USER="$HOME/Library/Application Support/Code/User"
if [[ -d "$HOME/Library/Application Support/Code" ]] || command -v code >/dev/null 2>&1; then
  echo "==> Linking VSCode keybindings"
  mkdir -p "$VSCODE_USER"
  if [[ -e "$VSCODE_USER/keybindings.json" && ! -L "$VSCODE_USER/keybindings.json" ]]; then
    mv "$VSCODE_USER/keybindings.json" "$VSCODE_USER/keybindings.json.backup"
    echo "    backed up existing keybindings.json -> keybindings.json.backup"
  fi
  ln -sfn "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_USER/keybindings.json"
fi

cat <<'EOF'

==> Done. Next steps:
  - Edit ~/.gitconfig.local          (git identity: name / email)
  - Edit ~/.config/zsh/secrets.zsh   (credentials / tokens)
  - Edit ~/.config/zsh/local.zsh     (machine-specific PATHs / toolchains)
  - Authenticate GitHub CLI:         gh auth login
  - (optional) import assets/iterm/* into iTerm2 if you still use it
  - Open a new terminal, or run:     exec zsh
EOF
