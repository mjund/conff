
export PATH="$PATH:/Users/dcod3/go/bin/"
export OPENAI_API_KEY="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"
export PATH="$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH"
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'


# Use vi mode
bindkey -v
export KEYTIMEOUT=1

# path
export PATH="$HOME/.local/bin/:$PATH"
bindkey -r '^u'


source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh


alias python="python3"
alias pip="pip3"
alias mxi="tmuxifier"
alias myip="curl http://ipecho.net/plain; echo"
alias ls="exa"
alias ta="tmux a"


export EDITOR=/usr/local/bin/hx

function mkcd {
  last=$(eval "echo \$$#")
  if [ ! -n "$last" ]; then
    echo "Enter a directory name"
  elif [ -d $last ]; then
    echo "\`$last' already exists"
  else
    mkdir $@ && cd $last
  fi
}


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


[ -f "/Users/dcod3/.ghcup/env" ] && source "/Users/dcod3/.ghcup/env" # ghcup-env