alias ls='ls -FGh --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -d .* --color=auto'

# jump back n directories at a time
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'

alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
alias du="du -c"
alias df="df -h"
alias mkdir='mkdir -pv'

alias t="top -ic"
alias free="free -mt"

alias diff='colordiff'

alias c='clear'
alias e='exit'
alias qq='exit'
#alias j='jobs -l'

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias install='sudo apt-get install'

alias grep='grep -i --color=auto'
alias egrep='egrep -i --color=auto'
alias fgrep='fgrep -i --color=auto'

alias v=vim
alias vi=vim
alias svi='sudo vi'

alias ports='netstat -tulanp'

alias meminfo='free -mlt'

alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

alias cpuinfo='lscpu'

alias ff='find . -name'

alias disk='du -S | sort -n -r | less'
alias folders='find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn'

alias gc='git commit -m'
alias gac='git commit -am'
alias gpl='git pull'
alias gp='git push'
alias gs='git status -s'
alias ga='git add'
alias gai='git add -i'
alias gl='git log --graph --oneline --decorate --max-count=10'

# recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

# show which commands use the most
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# search for process
alias tm='ps -ef | grep'

# find text in any file
ft() {
    find . -name "${2:-*}" | xargs grep -Hin "$1" 2>/dev/null
}

# show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'

# find the biggest in folder
alias ds='du -ks *|sort -n'

# repeat last command as root
alias sulast='sudo $(history -p !-1)'

# reload z shell
alias reload='source $HOME/.zshrc'

# exit terminal
alias q='exit'#
