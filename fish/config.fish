#################################################
# Global settings
#################################################

###################
# Helpers
###################
function __add_to_path
    if test (count $argv) = 1
        set -gx PATH $argv[1] $PATH
    else
        echo "Usage: __add_to_path <path>"
    end
end

function __reload_config
    source ~/.config/fish/config.fish
end

function __make_completion --argument alias command
  complete -c $alias -xa "(
    set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
    complete -C\"$command \$cmd\";
  )"
end



###################
# Environment
###################
set -gx EDITOR "vim"
set -gx GIT_EDITOR "vim"
set -gx GREP_OPTIONS "--color=auto"
set -gx CDPATH . "$HOME/code"


###################
# Colors
###################
set fish_greeting ""
set fish_color_command "green"

function colors_available
  for i in (seq 1 255)
    printf '\x1b[38;5;'$i'mcolour'$i'\n'
  end
end


###################
# Prompt
###################
function __user_host
  set -l content 
  echo -n (set_color --bold yellow)
  echo -n $USER@(hostname|cut -d . -f 1) (set color normal)
end

function __prompt_pwd
  echo -n ' '(set_color green)(pwd)(set_color normal)
end

set __fish_git_prompt_color 'magenta'
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_char_stateseparator ' '

set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_color_stagedstate 'green'

set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_color_dirtystate 'red'

set __fish_git_prompt_color_cleanstate 'green'

function fish_prompt
  echo -e ''
  __user_host
  __prompt_pwd
  __fish_git_prompt " "
  echo -e ''
  echo (set_color white)"> "(set_color normal)
end

function fish_right_prompt
  set -l st $status
  if [ $st != 0 ];
    echo (set_color red) ↵ $st(set_color normal)
  end
end



###################
# Interactive functions
###################
function icd
    tree --noreport -d -i -L 1 $CDPATH | grep -v '\(Users\|\.\)' | peco | read tempvar
    if [ $tempvar ]
        cd $tempvar
        commandline -f repaint
    end
end

function ifind
    set dir $argv
    if test (count $argv) -gt 2 -o (count $argv) -lt 1
        set dir (pwd)
    end
    find $dir | peco | tr "\n" " " | read tempvar
    if [ $tempvar ]
        commandline -i $tempvar
    end
end

function ihistory
    history | peco | read tempvar
    if [ $tempvar ]
        commandline $tempvar
    end
end

function ik
    ps -fea | awk '{$1=$3=$4=$5=$6=$7=""; print $0}' | peco | awk '{print $1}' | tr "\n" " " | read -l tempvar
    if test (count $tempvar) -gt 0
        kill $tempvar
    end
end

function ips
    ps -fea | awk '{$1=$3=$4=$5=$6=$7=""; print $0}' | peco | awk '{print $1}' | tr "\n" " " | read tempvar
    if [ $tempvar ]
        commandline -i $tempvar
    end
end

function ircd
    set dir $argv
    if test (count $argv) -gt 2 -o (count $argv) -lt 1
        set dir (pwd)
    end
    #find $dir -type d | peco | read tempvar
    find $dir -type d -not -path "*/.*/*" -not -name ".*" | peco | tr -d "\n" | read tempvar
    if [ $tempvar ]
        cd $tempvar
        commandline -f repaint
    end
end



###################
# Bindings
###################
function fish_user_key_bindings
    bind \cr ihistory
    bind \eo ips
    bind \ep ifind
    bind \ec icd
    bind \ew ighq
    bind \cp cdcode
end



###################
# Aliases
###################
alias vim   "vim"
#alias vim   "nvim"
alias vlc   "/opt/homebrew-cask/Caskroom/vlc/2.2.1/VLC.app/Contents/MacOS/VLC"
alias git   "hub"




#################################################
# Git
#################################################

####################
# Interative git branch
###################
function igitbranch
    git branch | peco | xargs git checkout
end

####################
# Git-Aliases
###################
alias g "git"
alias gx "gitx"



#################################################
# Barruscript
#################################################
function cdcode
  ls $HOME/code | peco | read tempvar
  if [ $tempvar ]
    cd $HOME/code/$tempvar
    commandline -f repaint
  end
end

function clone
  if test (count $argv) -lt 1
    echo "Nothing to clone"
    return
  end
  set code $HOME/code
  if test (count $argv) -eq 2
    if test (echo $argv[2] | egrep -v '^[/~]' | wc -l) -eq 1
      set target $code/$argv[2]
    else
      set target $argv[2]
    end
  else
    set target $code
  end
  if test (echo $argv[1] | egrep -v '[@:]' | wc -l) -eq 1
    set repo_name $argv[1]
    set flags '-p'
  else
    if test (echo $argv[1] | egrep -e '^http' | wc -l) -eq 1
      set repo_name (echo $argv[1] | cut -d ':' -f3)
else
      set repo_name (echo $argv[1] | cut -d':' -f2)
    end
  end
  set repo_name (echo $repo_name | cut -d'/' -f2 | sed 's/\.git$//')
  set target $target/$repo_name
  git clone $flags $argv[1] $target
end



#################################################
# Docker
#################################################

####################
# Helpers
###################
function __update_docker_host
        sudo sed -i '' '/[[:space:]]docker\.local$/d' /etc/hosts
        set -x DOCKER_IP (echo $DOCKER_HOST | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
    if [ $DOCKER_IP ]
            sudo /bin/bash -c "echo \"$DOCKER_IP        docker.local\" >> /etc/hosts"
    end
end

####################
# Functions
###################
function dm-load
    if test (count $argv) = 1
        docker-machine env $argv[1] | source
        set -gx DOCKER_TLS_VERIFY $DOCKER_TLS_VERIFY
        set -gx DOCKER_CERT_PATH $DOCKER_CERT_PATH
        set -gx DOCKER_HOST $DOCKER_HOST
        __update_docker_host
    else
        echo "Usage: docker-machine-load <machine name>"
    end
end

####################
# Aliases
###################
alias dm "docker-machine"
alias dc "docker-compose"



#################################################
# Trabescripts
#################################################
set -gx PATH ./bin $HOME/code/trabe-scripts/trabe/bin $PATH
#trabe init | source

#################################################
# SSH
#################################################
function ssh
  env TERM=xterm ssh $argv
end
