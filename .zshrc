if [[ -o interactive ]]; then
    fastfetch
fi

fpath+=(/usr/share/zsh/site-functions)

autoload -Uz compinit
compinit

eval "$(starship init zsh)"

# Load autosuggestions before highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load syntax highlighting (must be after autosuggestions)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias ls='eza --color=auto --long --icons -a --git --group-directories-first -H -i'
alias lsl='/usr/bin/ls --color=auto'

# binds
bindkey -v
export KEYTIMEOUT=10
