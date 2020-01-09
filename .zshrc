unsetopt BEEP

autoload -Uz colors && colors

autoload -Uz compinit && compinit
zmodload -i zsh/complist
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload zmv

export LANG=ja_JP.UTF-8

export PATH="/usr/local/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if [ -f ~/.nodebrew/nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

if [ -e /usr/local/share/git-core/contrib/diff-highlight ]; then
  export PATH=/usr/local/share/git-core/contrib/diff-highlight:$PATH
fi

if [ -e /usr/local/bin/src-hilite-lesspipe.sh ]; then
  export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
  export LESS="-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS"
fi

HISTFILE=~/.zsh-history
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
alias javac="javac -J-Dfile.encoding=UTF-8"
alias java="java -Dfile.encoding=UTF-8"

autoload -Uz add-zsh-hook

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '%s:%b'
zstyle ':vcs_info:*' actionformats '%s:%b|%a'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '%s:%b %c%u'
  zstyle ':vcs_info:git:*' actionformats '%s:%b|%a %c%u'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]=`echo "$vcs_info_msg_0_"$(_git_untracked)$(_git_unpushed) | tr -d " "`
}
add-zsh-hook precmd _update_vcs_info_msg

function _git_untracked() {
  if command git status --porcelain 2> /dev/null \
    | awk '{print $1}' \
    | command grep -F '??' > /dev/null 2>&1 ; then

    printf '?'
  fi
}

function _git_unpushed() {
  if [[ $(git symbolic-ref --short HEAD) != "master" ]]; then
    return 0
  fi

  local ahead
  ahead=$(git rev-list origin/master..master 2>/dev/null \
    | wc -l \
    | tr -d ' ')

  if [[ "$ahead" -gt 0 ]]; then
    printf "(*$ahead)"
  fi
}

PROMPT="%F{056}[%{$reset_color%}%~%F{056}]%1(v|%F{184}[%1v]|)
%F{032}%n@%m %F{198}%(!.#.») %{$reset_color%}"
