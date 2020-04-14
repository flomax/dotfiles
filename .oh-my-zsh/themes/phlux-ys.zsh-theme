# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Mar 2013 Yad Smood

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

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

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"
# hack for rprompt alignment
local _lineup=$'\e[1A'
local _linedown=$'\e[1B'

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $

# precmd() {
#   drawline=""
#   for i in {1..$COLUMNS}; drawline=" $drawline"
#   drawline="%U${drawline}%u"
# #then put as first line below +PLUS+ a trailing } at end
# %{$terminfo[bold]$fg[black]%}${drawline}%{$reset_color%}\
setopt promptsubst
 PROMPT="
%{$terminfo[bold]$fg[brightblue]%}»%{$terminfo[bold]$fg[brightblue]%}»%{$terminfo[bold]$fg[blue]%}»%{$fg[black]%}»%{$reset_color%} \
%{$terminfo[bold]$fg[yellow]%}%n%{$reset_color%}\
%{$fg[blue]%} @ \
%{$terminfo[bold]$fg[yellow]%}%m \
%{$fg[blue]%}in \
%{$terminfo[bold]$fg[green]%}%~%{$reset_color%}\
${hg_info}\
${git_info} \
 $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
RPROMPT=%{${_lineup}%}"%{$fg[black]%} %* "%{${_linedown}%}


