# colors
eval red='$FG[203]'
eval green='$FG[042]'
eval yellow='$FG[220]'
eval blue='$FG[075]'
eval magenta='$FG[147]'
eval cyan='$FG[051]'
eval white='$FG[231]'
eval grey='$FG[145]'

# The prompt
PROMPT='$(_user_host)%{$yellow%}%c $(git_prompt_info)%{$reset_color%}$(git_prompt_status)${_return_status}$ '

local _return_status="%{$reset_color%}"

function _user_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n%{$reset_color%}@%{$green%}%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  else
    me="%n"
  fi
  echo "%{$red%}$me%{$reset_color%}%{$reset_color%} in "
}

# Determine if there is an active Python virtual environment
function _python_venv() {
  if [[ $VIRTUAL_ENV != "" ]]; then
    echo "%{$grey%}(${VIRTUAL_ENV##*/})%{$reset_color%} "
  fi
}

ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{%F{yellow}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}on%{$blue%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$grey%}(Untracked) "
ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_ADDED="%{$green%}(Added) "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$yellow%}(Modified) "
ZSH_THEME_GIT_PROMPT_DELETED="%{$red%}(Deleted) "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$yellow%}(Renamed) "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$cyan%}(Unmerged) "
ZSH_THEME_GIT_PROMPT_AHEAD="%{$magenta%}(Ahead) "

