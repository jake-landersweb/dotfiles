# Redirect zsh's config directory into ~/.config/zsh so the repo never owns ~/.zshrc.
# ~/.zshrc then stays a plain, untracked file that tool installers can append to freely;
# the real entrypoint is ~/.config/zsh/.zshrc (which sources ~/.zshrc last).
export ZDOTDIR="$HOME/.config/zsh"
