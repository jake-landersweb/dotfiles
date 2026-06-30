# Zsh plugins are not vendored — they're cloned on first shell start into a single directory.
ZSH_PLUGIN_DIR="$HOME/.local/share/zsh"
[[ -d "$ZSH_PLUGIN_DIR" ]] || mkdir -p "$ZSH_PLUGIN_DIR"

# zplugin <name> <git-url> [source-file]
# Clones the plugin on first run, then sources <source-file> (relative to the plugin dir) if given.
zplugin() {
  local dir="$ZSH_PLUGIN_DIR/$1"
  [[ -d "$dir" ]] || git clone --depth=1 "$2" "$dir"
  [[ -n "$3" ]] && source "$dir/$3"
}

# Prompt
zplugin p10k https://github.com/romkatv/powerlevel10k.git powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# fzf-powered completion menu
zplugin fzf-tab https://github.com/Aloxaf/fzf-tab.git fzf-tab.plugin.zsh

# Extra completions (must be on fpath before compinit)
zplugin zsh-completions https://github.com/zsh-users/zsh-completions.git
fpath=("$ZSH_PLUGIN_DIR/zsh-completions/src" $fpath)

# Load completions
autoload -Uz compinit && compinit -u

# Syntax highlighting, substring history search, autosuggestions
zplugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting.zsh
zplugin zsh-history-substring https://github.com/zsh-users/zsh-history-substring-search zsh-history-substring-search.zsh
zplugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git zsh-autosuggestions.zsh
