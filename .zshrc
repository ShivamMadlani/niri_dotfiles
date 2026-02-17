HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

zshaddhistory() {
    local line=${1%%$'\n'}
    if [[ "$line" =~ "^(ls|cd|clear|exit|pwd|history)( |$)" ]]; then
        return 1
    fi
    return 0
}

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

fpath+=(/usr/share/zsh/site-functions)

# cache Starship
STARSHIP_CACHE="$HOME/.cache/.starship-init.zsh"

if [[ ! -f "$STARSHIP_CACHE" ]]; then
  starship init zsh --print-full-init > "$STARSHIP_CACHE"
  zcompile "$STARSHIP_CACHE"
fi

source "$STARSHIP_CACHE"

if [[ -o interactive ]]; then
    fastfetch
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source <(fzf --zsh)
fi

# aliases
alias ls='eza --color=auto --long --icons -a --group-directories-first -H'
alias lsl='/usr/bin/ls --color=auto'

# binds
bindkey -v
export KEYTIMEOUT=10
bindkey -M viins '^[[1;5D' backward-word
bindkey -M viins '^[[1;5C' forward-word

export GPG_TTY=$(tty)
