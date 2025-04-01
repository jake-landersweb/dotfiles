# Custom parsing code to make keyboard navigation easier
function zsh_custom_word_chars {
    local cmd=$1
    local chars=" \t\n\"\'!@#$%^&*()-=+[{]}\|;:,<.>/?"

    case $cmd in
        add)
            for c in $(echo "$chars" | fold -w1); do
            WORDCHARS="${WORDCHARS//${c}}"
            done
            ;;
        del)
            WORDCHARS="$chars"
            ;;
    esac
}

autoload -U select-word-style
select-word-style bash
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
zsh_custom_word_chars add

# Key bindings - only use ghostty
bindkey '^[[B' history-substring-search-down # downarr
bindkey '^[[A' history-substring-search-up # uparr

# fzf searching
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'case "$group" in "commit tag") git show --color=always $word ;; *) git show --color=always $word | delta ;; esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'case "$group" in "modified file") git diff $word | delta ;; "recent commit object name") git show --color=always $word | delta ;; *) git log --color=always $word ;; esac'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*' list-max-items 20
