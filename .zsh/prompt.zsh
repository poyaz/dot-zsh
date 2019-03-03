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

if [[ ${ZSH_THEME} = "xxf" ]]; then
fi
