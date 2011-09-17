source ~/.bashrc.local

# export VERSIONER_PYTHON_PREFER_32_BIT=yes

# Setup Amazon EC2 Command-Line Tools
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

# Set up Amazon IAM
export AWS_IAM_HOME=/Users/david/.ec2/iam/IAMCli-1.2.0
export PATH=$AWS_IAM_HOME/bin:$PATH
export AWS_CREDENTIAL_FILE=$AWS_IAM_HOME/david_cred.txt

# bash vi mode
set -o vi

alias v="~/bin/vim"
alias vn="vim --servername vim"
alias p="python"
alias o="open"
alias so="source"
alias axel="axel -a -n 10"
alias t='TERM=xterm-256color tmux attach'
alias wget='wget --no-check-certificate'

# ignore duplication and some simple commands in bash history
export HISTIGNORE="&:ls:[bf]g:exit"

# bash tab completion
bind "set completion-ignore-case on"

PATH=~/bin:$PATH

# Change directory back - 1-7 times - and forth with TAB-completion.
# Copyright (C) 2007-2008  Freddy Vulto
# Version: cdots-1.2.1
# Usage: .. [dir]
#        ... [dir]
#        .... [dir]
#        ..... [dir]
#        ...... [dir]
#        ....... [dir]
#        ........ [dir]

function _cdots() {
        # ':1' = Ignore dot at pos 0
    local dots=${COMP_WORDS[COMP_CWORD-1]:1} IFS=$'\n' i j=0
        #      +-----------2---------+ : Remove trailing `/*'s from PWD
        #      |     +-------1------+| : Replace every `.' with `/*'
    local dir="${PWD%${dots//\./\/\*}}/"
        # If first `compgen' returns no matches, try second `compgen'
        # which allows for globbing characters
    for i in $(
        compgen -d -- "$dir${COMP_WORDS[COMP_CWORD]}" ||
        compgen -d -X '!'"$dir${COMP_WORDS[COMP_CWORD]}*" -- $dir
    ); do
            #  If i not dir in current dir, append extra slash '/'
            #  NOTE: With bash > v2, if i is also dir in current dir, 
            #+       'complete -o filenames' automatically appends 
            #+       slash '/'
        (( $BASH_VERSINFO == 2 )) || [ ! -d ${i#$dir} ] && i="$i/"
        COMPREPLY[j++]="${i#$dir}"
    done
} # _cdots()

function cdots() {
    # If dir can't be found, try globbing with `eval'
    [ -d "$1$2" ] && cd "$1$2" || eval cd "$1$2"
} # cdots()

    # Define aliases .. ... .... etc, up to depth seven
    # NOTE: Functions are not defined directly as .. ... .... etc, 
    #       because these are not valid identifiers under `POSIX'
cdotsAlias=.; cdotsAliases=; cdotsDepth=7; cdotsDir=
while ((cdotsDepth--)); do
    cdotsAlias=$cdotsAlias.; cdotsDir=$cdotsDir../
    alias $cdotsAlias="cdots $cdotsDir"
    cdotsAliases="$cdotsAliases $cdotsAlias"
done
    # Set completion of aliases .. ... .... etc to _cdots()
    # -o filenames: Escapes whitespace
complete -o filenames -o nospace -F _cdots $cdotsAliases
unset -v cdotsDepth cdotsAlias cdotsAliases cdotsDir

#######################################################
# OS specific section starts here
#######################################################

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
elif [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

#######################################################
# OS X
#######################################################
if [[ $platform == 'osx' ]]; then

  # showing only username and pwd at the prompt
  PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

  PATH=/usr/local/Cellar/ruby/1.9.2-p136/bin:$PATH
  PATH=$PATH:/usr/texbin:/usr/X11/bin:~/src/go/bin:/usr/local/sbin
  PATH=/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH:/usr/local/bin

  CDPATH=$CDPATH:~/User/p3_PhD/

  alias joinpdf="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py"

  # Sort by cpu in OS X
  alias top="top -ocpu"

  source /usr/local/Cellar/coreutils/8.7/aliases 

  alias ls="ls -G"
  export LSCOLORS=dxfxcxdxbxegedabagacad

  export NODE_PATH=/usr/local/lib/node:/usr/local/node_modules

  if [ -f `brew --prefix`/etc/autojump ]; then
    . `brew --prefix`/etc/autojump
  fi
  export PATH=/usr/local/cuda/bin:$PATH
  export PATH=$PATH:/Developer/usr/bin
  export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH

  # Use bash completion
  # Need to run
  # >>> brew install bash-completion
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

#######################################################
# Linux
#######################################################
elif [[ $platform == 'linux' ]]; then
  alias ls="ls --color=auto"

  # Added by autojump install.sh
  source /etc/profile.d/autojump.bash
fi

