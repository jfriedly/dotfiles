# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias pgrep='pgrep -l'
fi

# Some more ls aliases.
alias ll='ls -hl'
alias la='ls -A'

# CSE-560 Java aliases.
#alias csejava="/usr/lib/jvm/java-6-sun/bin/java"
#alias checkstyles="java -jar $HOME/Dropbox/cse-560/checkstyle-5.5/checkstyle-5.5-all.jar -c $HOME/Dropbox/cse-560/cse421Style.xml"

# Prints my ip address when I type myip.
alias myip="curl ifconfig.me"

# Dofus, an awesome French MMORPG.  Check it out sometime.
alias dofus="$HOME/ankama/Dofus/share/UpLauncher &"

# I made a set of scripts for playing youtube videos from the terminal, and
# put these in $HOME/.bin.  But I always get my ytps command mixed up with
# ytsp.
alias ytsp="ytps"

# HipChat, the XMPP-based chat client that we cyrrently use at Nebula.
alias hipchatair="/opt/HipChat/bin/HipChat"

# Minecraft, an amazing Java-based game.
alias minecraft="java -jar $HOME/games/minecraft.jar"
# Play any version of Minecraft!
alias minecraft1.3.2="rm -f $HOME/.minecraft; ln --symbolic $HOME/.minecraft1.3.2 $HOME/.minecraft; java -jar $HOME/games/minecraft.jar"
alias minecraft1.4.2="rm -f $HOME/.minecraft; ln --symbolic $HOME/.minecraft1.4.2 $HOME/.minecraft; java -jar $HOME/games/minecraft.jar"
alias minecraft1.4.4="rm -f $HOME/.minecraft; ln --symbolic $HOME/.minecraft1.4.4 $HOME/.minecraft; java -jar $HOME/games/minecraft.jar"
alias minecraft1.4.5="rm -f $HOME/.minecraft; ln --symbolic $HOME/.minecraft1.4.5 $HOME/.minecraft; java -jar $HOME/games/minecraft.jar"
alias minecraft1.4.6="rm -f $HOME/.minecraft; ln --symbolic $HOME/.minecraft1.4.6 $HOME/.minecraft; java -jar $HOME/games/minecraft.jar"
alias minecraft1.4.7="rm -f $HOME/.minecraft; ln --symbolic $HOME/.minecraft1.4.7 $HOME/.minecraft; java -jar $HOME/games/minecraft.jar"
alias minecraft1.5.2="rm -f $HOME/.minecraft; ln --symbolic $HOME/.minecraft1.5.2 $HOME/.minecraft; java -jar $HOME/games/minecraft.jar"

# I go to my classes folder in Dropbox all the time.
alias cl="cd $HOME/Dropbox/classes/"

# Cache my ssh key.  It's only two commands, but I haven't figured out how to
# compress these into one alias.
alias unlockssh="source $HOME/.bin/unlock-ssh-key.sh"

# Pipe stdout to this alias and it will put the stdout in a pastebin at
# http://ix.io, printing the url to the terminal.
alias pastebin="curl --form 'f:1=<-' http://ix.io"

# Pipe stout to this alias and it will text me the info after the command
# completes.
alias txtme="gcsms.py send"

# Video conferencing.
alias vidyo="VidyoDesktop"

# Startup a simple HTTP server for the current directory on port 8080.
alias serveme="python -m SimpleHTTPServer 8080"

# Pipe json to prettyprint to pretty print it.
alias prettyprint="python -m json.tool"

# Launching uplink from in steam makes it full screen by default.
alias uplink="$HOME/.steam/steam/SteamApps/common/Uplink/uplink.bin.x86_64"
