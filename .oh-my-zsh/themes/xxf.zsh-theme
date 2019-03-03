# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
#local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_PREFIX1="%{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%} "
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✗"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}✔︎"

# Git info.
local git_info='$(git_prompt_info)'
#local git_last_commit='$(git log --pretty=format:"%h \"%s\"" -1 2> /dev/null)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# Dir options
SHORTEN_DIR_LENGTH=2
SHORTEN_DELIMITER='..'

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

function join { local IFS="$1"; shift; echo "$*"; }

prompt_dir() {
  # using $PWD instead of "$(print -P '%~')" to allow use of POWERLEVEL9K_DIR_PATH_ABSOLUTE
  local current_path=$PWD # WAS: local current_path="$(print -P '%~')"
  
  # declare all local variables
  local paths directory test_dir test_dir_length trunc_path threshhold

  # if we are not in "~" or "/", split the paths into an array and exclude "~"
  (( ${#current_path} > 1 )) && paths=(${(s:/:)${current_path//"~\/"/}}) || paths=()

  local delim=$(echo -n '/')

  if [ ${#current_path} -gt $(( $SHORTEN_DIR_LENGTH + ${#SHORTEN_DELIMITER} )) ]; then
    current_path=$SHORTEN_DELIMITER$delim$(join / ${paths:(-SHORTEN_DIR_LENGTH)})
  fi
 
  local state_path="$(print -P '%~')"
  IFS='/' read state_path_1 state_path_2 state_path_3 <<< "$state_path"
 

  if [[ $state_path == '~' ]]; then
    current_path='~'
  elif [[ $state_path_1 == '~' && -n $state_path_2 && -z $state_path_3 ]]; then
    current_path="$state_path_1$delim$state_path_2"
  elif [[ $state_path == '/' ]]; then
    current_path='/'
  fi

  echo "${current_path}"
}

current_dir="$(prompt_dir)"
return_code="%(?..%{$fg_bold[red]%}%? :(%{$reset_color%})"

# Prompt format: \n # TIME USER at MACHINE in [DIRECTORY] on git:BRANCH STATE \n $ 
PROMPT="
%{$fg[cyan]%}%n\
%{$fg[white]%}@\
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}[$current_dir]%{$reset_color%} \
%{$return_code%}\
${hg_info} \
${git_info} \
${git_last_commit}
 \
%{$terminfo[bold]$fg[white]%}→ %{$reset_color%}"

# %{$fg[red]%}%* \

if [[ "$USER" == "root" ]]; then
PROMPT="
%{$fg[red]%}%* \
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%}\
%{$fg[white]%}@\
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}[${current_dir}]%{$reset_color%} \
%{$return_code%}\
${hg_info}\
${git_info}
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
fi
