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

# fzf tab menu
plugin="$ZSH_CONFIG_ROOT/fzf-tab"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git $plugin
fi
source "$plugin/fzf-tab.plugin.zsh"
# plugin="$ZSH_CONFIG_ROOT/zsh-autocomplete"
# if [[ ! -d "$plugin" ]]; then
#   git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git $plugin
# fi
# source "$plugin/zsh-autocomplete.plugin.zsh"

# more completions
plugin="$ZSH_CONFIG_ROOT/zsh-completions"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git $plugin
fi
fpath=($plugin/src $fpath)

# Load completions
autoload -Uz compinit && compinit -u

# syntax highlighting
plugin="$ZSH_CONFIG_ROOT/zsh-syntax-highlighting"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $plugin
fi
source "$plugin/zsh-syntax-highlighting.zsh"

# substring history
plugin="$ZSH_CONFIG_ROOT/zsh-history-substring"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search $plugin
fi
source $plugin/zsh-history-substring-search.zsh

# auto suggestions
plugin="$ZSH_CONFIG_ROOT/zsh-autosuggestions"
if [[ ! -d "$plugin" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $plugin
fi
source "$plugin/zsh-autosuggestions.zsh"


###

# Homebrew on macOS
export HOMEBREW_NO_AUTO_UPDATE=1
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
 
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

export TERM=xterm-256color

# Base config
if [[ -f "$HOME/.zsh_config_base" ]]; then
  source "$HOME/.zsh_config_base"
else
  echo "$HOME/.zsh_config_base is required to exist."
fi

# Specific computer config
if [[ -f "$HOME/.zsh_config" ]]; then
  source "$HOME/.zsh_config"
else
  echo "$HOME/.zsh_config is required to exist."
fi

# Keybindings
if [[ -f "$HOME/.zsh_keys" ]]; then
  source "$HOME/.zsh_keys"
fi

# Shell integrations
eval "$(fzf --zsh)"

# Additional Integrations
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
