function git_prompt_info {
  local ref=$(=git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(=git status 2> /dev/null)"

  if [[ -f .git/MERGE_HEAD ]]; then
    if [[ ${gitst} =~ "unmerged" ]]; then
      gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
    else
      gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
    fi
  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus=" %{$fg[blue]%}!%{$reset_color%}"
  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus=" %{$fg[red]%}!%{$reset_color%}"
  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus=" %{$fg[yellow]%}*%{$reset_color%}"
  else
    gitstatus=''
  fi

  if [[ -n $ref ]]; then
    echo "%{$fg_bold[green]%}/${ref#refs/heads/}%{$reset_color%}$gitstatus"
  fi
}


#PROMPT='%~%<< $(git_prompt_info)${PR_BOLD_WHITE}>%{${reset_color}%} '
#
#if [[ ${ZSH_THEME} = "re5et" ]]; then
#  local return_code="%(?..%{$fg_bold[red]%}[%?]%{$reset_color%})"
#  local git_project=""

#  if [[ -d .git ]]; then
#    git_project="%{$color[bold]%}project: %{$reset_color%}$(git remote -v | cut -d':' -f 2 | grep fetch | sed 's/^\/\/\([^/]\+\/\)\(.*\)\(\.git.*\)/\2/g')"
#  fi

#  PROMPT='
#%{$fg_bold[cyan]%}%n%{$reset_color%}%{$fg[yellow]%}@%{$reset_color%}%{$fg_bold[blue]%}%m%{$reset_color%}${return_code}:%{${fg_bold[green]}%}%~%{$reset_color%}
#${git_project}
#%{${fg[$CARETCOLOR]}%}> %{${reset_color}%}'

  #RPS1='${return_code}'
#fi

if [[ ${ZSH_THEME} = "powerlevel9k/powerlevel9k" ]]; then
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="#> "

  POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir vcs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status custom_node_version ram)

  POWERLEVEL9K_CUSTOM_NODE_VERSION="get_node_version"
  POWERLEVEL9K_CUSTOM_NODE_VERSION_BACKGROUND="green"
  POWERLEVEL9K_CUSTOM_NODE_VERSION_FOREGROUND="white"
  POWERLEVEL9K_CUSTOM_NODE_VERSION_ICON="\u2191"

  POWERLEVEL9K_OS_ICON_BACKGROUND="white"
  POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
  POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

  get_node_version() {
    ! [[ $(pwd | grep nodejs) ]] && return;

    local node_version=$(node -v 2>/dev/null)

    echo "${node_version:1} \u2B22"
  }
fi
