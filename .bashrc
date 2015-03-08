# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions
# 2014-01-31
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias Egrep='egrep -n -v "^#|^$"'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

#Autoriser sudo a utiliser les alias
alias sudo='sudo '

export PATH=$PATH:~/bin/python3/bin/

export http_proxy=http://IP:PORT/
export https_proxy=http://IP:PORT/
export no_proxy="localhost,127.0.0.1,10.75.68.75,.caphitech.com"
df ()
{
  ( printf "Filesystem Type Size Used Avail Use%% Mounted_on\n";
  /bin/df -PTH $* | sed 1d ) | column -t
}

#2014-08-12
if declare -F __git_ps1 &> /dev/null; then
  export PS1="[\[\e[1;32m\]\u@\h\[\033[01;33m\] \w \[\033[31m\]\$(__git_ps1)\[\033[00m\]$\[\033[00m\] "
else
  export PS1="[\[\e[1;32m\]\u@\h\[\033[01;33m\] \w \[\033[00m\]\$ "
fi
