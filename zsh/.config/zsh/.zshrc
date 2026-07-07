# Powerlevel10k instant prompt — must stay near the top, before anything that prints.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# Homebrew on macOS (Apple Silicon)
export HOMEBREW_NO_AUTO_UPDATE=1
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Shared user scripts (stowed from the dotfiles `scripts` package).
export PATH="$HOME/.local/bin:$PATH"

# Prompt, plugins, completions
source "$ZDOTDIR/plugins.zsh"

# History
HISTSIZE=10000
HISTFILE="$HOME/.zsh_history"
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

# Shared config (aliases) + keybindings
source "$ZDOTDIR/base.zsh"
source "$ZDOTDIR/keys.zsh"

# Personal, gitignored overrides. Silent if absent (fresh laptop).
#   local.zsh   -> machine-specific PATHs / toolchains
#   secrets.zsh -> credentials & tokens
#   local.d/*.zsh -> drop-in files for any number of additional env/credential sets
[[ -f "$ZDOTDIR/local.zsh" ]]   && source "$ZDOTDIR/local.zsh"
[[ -f "$ZDOTDIR/secrets.zsh" ]] && source "$ZDOTDIR/secrets.zsh"
for f in "$ZDOTDIR"/local.d/*.zsh(N); do
  source "$f"
done

# Shell integrations
eval "$(fzf --zsh)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Tool auto-writes land in ~/.zshrc / ~/.zprofile (untracked, since ZDOTDIR points elsewhere).
# Source them last so installer-appended PATH/eval lines still take effect immediately,
# while the repo stays clean. Migrate the keepers into local.zsh / secrets.zsh at leisure.
[[ -f "$HOME/.zshrc" ]]    && source "$HOME/.zshrc"
[[ -f "$HOME/.zprofile" ]] && source "$HOME/.zprofile"
