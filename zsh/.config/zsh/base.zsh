########################################
# Aliases (shared across all machines)
########################################
if command -v eza &> /dev/null; then
    alias ls="eza --icons=auto"
    alias ll="ls -l -a -H"
else
    alias ls="ls --color=auto"
    alias ll="ls -lah"
fi
alias l="ls"
alias szp="exec zsh"            # reload the shell
alias zp="code ~/dotfiles"
alias clear_dns="sudo killall -HUP mDNSResponder"

# App launchers (macOS)
alias code="open -a \"Visual Studio Code\""
alias cursor="open -a \"Cursor\""
alias assume="source /opt/homebrew/bin/assume"

# git shortcuts
alias gs="git status"
alias gc="git checkout"
alias com="git add -A && git commit -m"