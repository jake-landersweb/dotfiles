# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# host all files in a singular directory
ZSH_CONFIG_ROOT="$HOME/.local/share/zsh"
if [[ ! -d "$ZSH_CONFIG_ROOT" ]]; then
  mkdir -p $ZSH_CONFIG_ROOT
fi

# p10k
if [[ ! -d "$ZSH_CONFIG_ROOT/p10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CONFIG_ROOT/p10k
fi
source "$ZSH_CONFIG_ROOT/p10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### PLUGINS

# syntax highlighting
plugin="$ZSH_CONFIG_ROOT/zsh-syntax-highlighting"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $plugin
fi
source "$plugin/zsh-syntax-highlighting.zsh"

# more completions
plugin="$ZSH_CONFIG_ROOT/zsh-completions"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git $plugin
fi
fpath=($plugin/src $fpath)

# auto suggestions
plugin="$ZSH_CONFIG_ROOT/zsh-autosuggestions"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $plugin
fi
source "$plugin/zsh-autosuggestions.zsh"

# fzf tab menu
plugin="$ZSH_CONFIG_ROOT/fzf-tab"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git $plugin
fi
source "$plugin/fzf-tab.plugin.zsh"

###

# Homebrew on macOS
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Path -- custom to each installation
PATH="$HOME/.cargo/bin:$PATH" # rust
PATH="$PATH:/usr/local/bin/flutter/bin" # flutter
PATH="$PATH":"$HOME/.pub-cache/bin" # flutter
PATH="$PATH:/usr/local/bin/cpdf/bin" # cpdf *.pdf -o all.pdf
PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH" # psql
PATH="$PATH:/usr/local/bin/xpdf-tools-mac-4.05/binARM"
PATH="$PATH:$HOME/go/bin" # go

export PNPM_HOME="$HOME/Library/pnpm"
PATH="$PNPM_HOME:$PATH"

# Load completions
autoload -Uz compinit && compinit
 
# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# custom source scripts
export TERM=xterm-256color

# Aliases
if [[ -f "$HOME/.zsh_alias" ]];then
  source "$HOME/.zsh_alias"
fi

# Functions
if [[ -f "$HOME/.zsh_functions" ]];then
  source "$HOME/.zsh_functions"
fi

# Keybindings
if [[ -f "$HOME/.zsh_keys" ]];then
  source "$HOME/.zsh_keys"
fi

# Secrets
if [[ -f "$HOME/.zsh_secrets" ]];then
  source "$HOME/.zsh_secrets"
fi

# Shell integrations
eval "$(fzf --zsh)"

# Additional Integrations
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
