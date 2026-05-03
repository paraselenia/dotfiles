unsetopt BEEP

typeset -U PATH

autoload -Uz colors && colors

autoload -Uz compinit && compinit
zmodload -i zsh/complist
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload zmv

export LANG=ja_JP.UTF-8
export GPG_TTY=$TTY

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

export PATH="/usr/local/bin:$PATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which nodebrew > /dev/null; then export PATH=$HOME/.nodebrew/current/bin:$PATH; fi
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

if [ -x "$(brew --prefix git)/share/git-core/contrib/diff-highlight/diff-highlight" ]; then
  export PATH=$(brew --prefix git)/share/git-core/contrib/diff-highlight:$PATH
fi

if [ -e "$(brew --prefix)/bin/src-hilite-lesspipe.sh" ]; then
  export LESSOPEN="| $(brew --prefix)/bin/src-hilite-lesspipe.sh %s"
  export LESS="-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS"
fi

if [ -e "$(brew --prefix)/opt/coreutils/libexec/gnubin" ]; then
  export PATH=$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH
fi

if [ -e "$(brew --prefix)/opt/gnu-sed/libexec/gnubin" ]; then
  export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
fi

if [ -e $HOME/go/bin ]; then
  export PATH=$HOME/go/bin:$PATH
fi

if [ -e $HOME/.cargo/bin ]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi

if [ -e $HOME/.orbstack/bin ]; then
  export PATH=$HOME/.orbstack/bin:$PATH
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]; then
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt hist_no_store

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt correct
setopt nolistbeep
setopt list_packed

alias ls="ls -G"
alias zmv='noglob zmv -W'

if builtin command -v mise > /dev/null; then
  eval "$(mise activate zsh)"
fi

if builtin command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi
