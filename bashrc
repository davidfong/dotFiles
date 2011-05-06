source ~/.bashrc.local

export VERSIONER_PYTHON_PREFER_32_BIT=yes

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

alias v="~/bin/vim -X"
alias vn="vim --servername vim"
alias p="python"
alias o="open"
alias so="source"
alias axel="axel -a -n 10"
alias t='TERM=xterm-256color tmux attach'

# ignore duplication and some simple commands in bash history
export HISTIGNORE="&:ls:[bf]g:exit"

# bash tab completion
bind "set completion-ignore-case on"

PATH=~/bin:$PATH

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

if [[ $platform == 'osx' ]]; then

  #######################################################
  # OS X
  #######################################################

  # showing only username and pwd at the prompt
  PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

  PATH=/usr/local/Cellar/ruby/1.9.2-p136/bin:$PATH
  PATH=$PATH:/usr/texbin:/usr/X11/bin:~/src/go/bin:/usr/local/sbin
  PATH=$PATH:/usr/local/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin

  CDPATH=$CDPATH:~/User/p3_PhD/

  alias joinpdf="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py"

  # Sort by cpu in OS X
  alias top="top -ocpu"

  source /usr/local/Cellar/coreutils/8.7/aliases 

  alias ls="ls -G"
  export LSCOLORS=dxfxcxdxbxegedabagacad

  export NODE_PATH=/usr/local/lib/node:/usr/local/node_modules

  # autojump
  _autojump() 
  {
          local cur
          cur=${COMP_WORDS[*]:1}
          while read i
          do
              COMPREPLY=("${COMPREPLY[@]}" "${i}")
          done  < <(autojump --bash --completion $cur)
  }
  complete -F _autojump j
  data_dir=$([ -e ~/.local/share ] && echo ~/.local/share || echo ~)
  export AUTOJUMP_HOME=${HOME}
  if [[ "$data_dir" = "${HOME}" ]]
  then
      export AUTOJUMP_DATA_DIR=${data_dir}
  else
      export AUTOJUMP_DATA_DIR=${data_dir}/autojump
  fi
  if [ ! -e "${AUTOJUMP_DATA_DIR}" ]
  then
      mkdir "${AUTOJUMP_DATA_DIR}"
      mv ~/.autojump_py "${AUTOJUMP_DATA_DIR}/autojump_py" 2>>/dev/null #migration
      mv ~/.autojump_py.bak "${AUTOJUMP_DATA_DIR}/autojump_py.bak" 2>>/dev/null
      mv ~/.autojump_errors "${AUTOJUMP_DATA_DIR}/autojump_errors" 2>>/dev/null
  fi

  AUTOJUMP='{ [[ "$AUTOJUMP_HOME" == "$HOME" ]] && (autojump -a "$(pwd -P)"&)>/dev/null 2>>${AUTOJUMP_DATA_DIR}/autojump_errors;} 2>/dev/null'
  if [[ ! $PROMPT_COMMAND =~ autojump ]]; then
    export PROMPT_COMMAND="${PROMPT_COMMAND:-:} ; $AUTOJUMP"
  fi 
  alias jumpstat="autojump --stat"
  function j { new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";else false; fi }

elif [[ $platform == 'linux' ]]; then
  #######################################################
  # Linux
  #######################################################
  alias ls="ls --color=auto"

fi

