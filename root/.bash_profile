export GOROOT=/opt/go/goroot
export SCALA_HOME=/opt/scala
export GOPATH=/opt/go/gopath
export PATH="$PATH:$SCALA_HOME/bin:$GOROOT/bin:$GOPATH/bin"
export EDITOR=vim

cdg() {
    cd /home/projects/src/github.com
    [ "$1" != "" ] && cd $1
}

cdp() {
    cd /home/projects/src
    [ "$1" != "" ] && cd $1
}

alias g=git
alias gg="git grep -i --color"
alias ff="find .|grep -i"
#an alias to show the latest commit for each file. This also shows which files are in git
alias gl='for i in $(ls -A);do printf "%-32s %s\n" "$i" "$(git log -n1 --oneline $i)";done'
[ -f /opt/hub/hub ] && alias git=/opt/hub/hub
alias ts="perl -e 'use Time::HiRes; while(<>) { print Time::HiRes::time."'" "'".\$_;}'"
alias tidy="find lib t -name '*.p[lm]' -o -name '*.t' | xargs perl -I /usr/local/perl/lib/perl5 /usr/local/perl/bin/perltidy -pro=/root/.perltidyrc --backup-and-modify-in-place -bext=tidyup;find . -name '*.tidyup' -delete"
alias sa='ssh-agent -k 2> /dev/null;eval "$(ssh-agent -s)";ssh-add ~/.ssh/id_rsa'
alias ct='ctags -R *'

alias clsps='docker ps -a |tail -n +2|tr -s " "|cut -d" " -f 1|xargs docker rm -f'
alias clsim='docker images|tail -n +2|tr -s " "|cut -d" " -f 3|xargs docker rmi -f'
alias d='docker'
alias dc='docker-compose'

source /home/share/git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

[[ -f /usr/share/bash-completion/completions/git ]] && source /usr/share/bash-completion/completions/git

complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
    || complete -o default -o nospace -F _git g

source /opt/perl5/etc/bashrc #perlbrewrc
