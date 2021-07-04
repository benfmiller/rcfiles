# https://medium.com/@damianczapiewski/how-to-pimp-up-the-git-bash-prompt-on-windows-without-any-external-stuff-c69eb9ef0125
# https://blog.devgenius.io/how-to-customize-the-git-bash-shell-prompt-336f6aefcf3f

# origin_dist () {
#  local STATUS="$(git status 2> /dev/null)"
#  local DIST_STRING=""
#  local IS_AHEAD=$(echo -n "$STATUS" | grep "ahead")
#  local IS_BEHIND=$(echo -n "$STATUS" | grep "behind")
#  if [ ! -z "$IS_AHEAD" ]; then
#   local DIST_VAL=$(echo "$IS_AHEAD" | sed 's/[^0-9]*//g')
#   DIST_STRING="$DIST_VAL ››"
#  elif [ ! -z "$IS_BEHIND" ]; then
#   local DIST_VAL=$(echo "$IS_BEHIND" | sed 's/[^0-9]*//g')
#   DIST_STRING="‹‹ $DIST_VAL"
#  fi
#  if [ ! -z "$DIST_STRING" ]; then
#   echo -en "\e[1;7m $DIST_STRING "
#  fi
# }

# __PS1_GIT_DIST='`origin_dist`'

# __PS1="${__PS1_BEFORE}${__PS1_TIME}${__PS1_USER}${__PS1_LOCATION}${__PS1_GIT_BRANCH}${__PS1_GIT_DIST}${__PS1_AFTER}"
# ORIG_PS1="$PS1"


# git_stats() {
#   local STATUS=$(git status -s 2> /dev/null)
#   local ADDED=$(echo "$STATUS" | grep '??' | wc -l)
#   local DELETED=$(echo "$STATUS" | grep ' D' | wc -l)
#   local MODIFIED=$(echo "$STATUS" | grep ' M' | wc -l)
#   local STATS=''
#   if [ $ADDED != 0 ]; then
#     STATS="\e[42m $ADDED "
#   fi
#   if [ $DELETED != 0 ]; then
#     STATS="$STATS\e[101m $DELETED "
#   fi
#   if [ $MODIFIED != 0 ]; then
#     STATS="$STATS\e[30;103m $MODIFIED "
#   fi
#   echo -e "\e[0m    $STATS\e[0m"
# }
# __PS1_BEFORE='\[\e[42;97m\] \t '
# __PS1_USER='\[\e[97;104m\] \u@\h '
# __PS1_LOCATION='\[\e[30;43m\] \w '
# __PS1_GIT_BRANCH='\[\e[97;45m\]`__git_ps1` ' __PS1_GIT_STATS='`git_stats` '
# __PS1_AFTER='\[\e[0m\]\n\[\e[42;97m\]\$ \[\e[0m\] '

# # export PS1="${__PS1_BEFORE}${__PS1_USER}${__PS1_LOCATION}${__PS1_GIT_BRANCH}${__PS1_GIT_STATS}${__PS1_AFTER}"
# # export PS1="${__PS1_BEFORE}${__PS1_USER}${__PS1_GIT_BRANCH}${__PS1_AFTER}"
# export PS1="\t ${PS1}"

# -----------------------------------------------------------------------------------------------------------------

# from c/program files/Git/etc/profile.d/git-prompt.sh

if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
	# PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'\[\033[94m\]\t '     # time
	PS1="$PS1"'\[\033[32m\]'       # change to green
	PS1="$PS1"'\u@\h '             # user@host<space>
	PS1="$PS1"'\[\033[35m\]'       # change to purple
	PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
	PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
	PS1="$PS1"'\w'                 # current working directory
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[36m\]'  # change color to cyan
			PS1="$PS1"'`__git_ps1`'   # bash function
		fi
	fi
	PS1="$PS1"'\[\033[0m\]'        # change color
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'$ '                 # prompt: always $
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi
