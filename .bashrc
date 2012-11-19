# ~/.bashrc: executed by bash(1) for non-login shells.
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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# virtualenvwrapper stuff
if [ -e /usr/local/bin/virtualenvwrapper.sh ]
then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/git
    source /usr/local/bin/virtualenvwrapper.sh
fi

# jdk and jre stuff
export JAVA_HOME=/usr/lib/jvm/java-6-sun
export PATH=$PATH:$JAVA_HOME/bin
alias csejava="/usr/lib/jvm/java-6-sun/bin/java"
alias checkstyles="java -jar ~/Dropbox/cse-560/checkstyle-5.5/checkstyle-5.5-all.jar -c ~/Dropbox/cse-560/cse421Style.xml"

# CVS stuff
export CVSROOT=:pserver:friedly@stdlinux.cse.ohio-state.edu:/project/c560aa03/CVSREP

export PATH=$PATH:$HOME/.bin:./

export EDITOR=`which vim`

if [ -e $HOME/.bin ] && [ -e HOME/.bin/pythonrc.py ]; then
    export PYTHONSTARTUP=$HOME/.bin/pythonrc.py
fi

# I can afford the extra few KB to have a huge history :)
export HISTFILESIZE=10000

# Because grep should be pretty.
alias grep="grep --color"

# prints my ip address when I type myip
alias myip="curl ifconfig.me"

# dofus
alias dofus="$HOME/ankama/Dofus/share/UpLauncher &"

# terminal youtube stuff:
alias ytsp="ytps"

# hipchat
alias hipchat="/opt/HipChat/bin/HipChat"

# minecraft
alias minecraft="java -jar $HOME/games/minecraft.jar"
# other versions of minecraft
alias minecraft1.3.2="unlink $HOME/.minecraft && ln -s $HOME/.minecraft1.3.2 $HOME/.minecraft && java -jar $HOME/games/minecraft.jar"
alias minecraft1.4.2="unlink $HOME/.minecraft && ln -s $HOME/.minecraft1.4.2 $HOME/.minecraft && java -jar $HOME/games/minecraft.jar"
alias minecraft1.4.4="unlink $HOME/.minecraft && ln -s $HOME/.minecraft1.4.4 $HOME/.minecraft && java -jar $HOME/games/minecraft.jar"


# I go to my classes folder in Dropbox all the time
alias cl="cd $HOME/Dropbox/classes/"
