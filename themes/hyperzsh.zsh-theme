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
PROMPT='$(_user_host)$(_python_venv)%{$yellow%}%c $(git_prompt_info)%{$reset_color%}$(git_prompt_status)${_return_status}> '

local _return_status="%{$reset_color%}"

function _user_host() {
    echo "%{$red%}%n%{$reset_color%}%{$white%} in " 
}

# Determine if there is an active Python virtual environment
function _python_venv() {
  if [[ $VIRTUAL_ENV != "" ]]; then
    echo "%{$blue%}(${VIRTUAL_ENV##*/})%{$reset_color%} "
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

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$white%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$yellow%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$red%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$white%}"

#
# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
# Only proceed if there is actually a commit.
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d "
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m "
    else
      commit_age="${minutes}m "
    fi
    if [[ -n $(git status -s 2> /dev/null) ]]; then
        if [ "$hours" -gt 4 ]; then
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
        elif [ "$minutes" -gt 30 ]; then
            COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
        fi
    else
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
    fi


    echo "$COLOR$commit_age%{$reset_color%}"
  fi
}
