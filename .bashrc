# $HOME/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# I can afford the extra few KB to have a huge history :)
# Be sure that your history doesn't contain any plain text passwords or RSA
# keys though!
export HISTSIZE=10000
export HISTFILESIZE=400000000

# Whenever a new prompt is opened, configure it to immediately write all
# history lines.
PROMPT_COMMAND="history -a"
export HISTSIZE PROMPT_COMMAND

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
    else
color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Fix my spelling errors when using cd
shopt -s cdspell

# Alias definitions.
# I put all my aliases into $HOME/.bash_aliases, instead of adding them here
# directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $HOME/.bash_aliases.sh ]; then
    . $HOME/.bash_aliases.sh
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Setup up virtualenvwrapper.
if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/git
    export VIRTUALENVWRAPPER_WORKON_CD=0
    source /usr/local/bin/virtualenvwrapper.sh
fi

# Setup Java stuff for CSE-560.
#export JAVA_HOME=/usr/lib/jvm/java-6-sun
#export PATH=$PATH:$JAVA_HOME/bin

# CVS stuff for CSE-560
#export CVSROOT=:pserver:friedly@stdlinux.cse.ohio-state.edu:/project/c560aa03/CVSREP

# Set the default editor to vim.
export EDITOR=`which vim`

# I like to put my own binaries in $HOME/.bin
if [ -e $HOME/.bin ]; then
    export PATH=$HOME/.bin:$PATH
    # I occasionally use a pythonrc in my .bin folder.
    if [ -e $HOME/.bin/pythonrc.py ]; then
        export PYTHONSTARTUP=$HOME/.bin/pythonrc.py
    fi
fi

# I can afford the extra few KB to have a huge history :)
# Be sure that your history doesn't contain any plain text passwords or RSA
# keys though!
export HISTSIZE=10000
export HISTFILESIZE=400000000

# Whenever a new prompt is opened, configure it to immediately write all
# history lines.
PROMPT_COMMAND="history -a"
export HISTSIZE PROMPT_COMMAND

# TinyOS stuff for CSE 5473
export MAKERULES=/opt/tinyos-2.1.2/support/make/Makerules
export TOSDIR=/opt/tinyos-2.1.2/tos

# Vim-style marks for bash
export MARKPATH=$HOME/.marks
function jump { 
        cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark { 
        mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark { 
        rm -if $MARKPATH/$1 
}
function marks {
        ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}

                                  complete -F _completemarks jump unmark

# OpenStack credentials are stored in $HOME/.openrc
if [ -e $HOME/.openrc ]; then
    source $HOME/.openrc
fi

# Cargo is Rust's package manager
if [ -d $HOME/.cargo ]; then
    source "$HOME/.cargo/env"
fi

# I use local bashrc's occasionally
if [ -e $HOME/.local_bashrc ]; then
    source $HOME/.local_bashrc
fi
