#
# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║     
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║     
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# zmodload zsh/zprof

# $PATH {{{
# /etc/paths: /usr/local/bin /usr/bin /bin /usr/sbin /sbin
# export PATH="/opt/CHARMM/c38b2/exec/osx/:$PATH"               # <-- CHARMM
# export PATH="/Developer/NVIDIA/CUDA-9.1/bin:$PATH"            # <-- CUDA
# export PATH="/Applications/moe2018/bin:$PATH"                 # <-- Moe2018
# export PATH="$HOME/.iterm2:$PATH"                             # <-- iterm2
# export PATH="$HOME/bin:$PATH"                                 # <-- ~/bin
export PATH="$HOME/usr/bin:$PATH"                            # <-- personal stuff
export PATH="$HOME/.cargo/bin:$PATH"                          # <-- cargo
# export PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"                 # <-- ruby gem
export PATH="$HOME/.yarn/bin:$PATH"                           # <-- yarn (node)
export PATH="$HOME/.local/bin:$PATH"                          # <-- local/bin
source /opt/anaconda3/etc/profile.d/conda.sh                  # <-- Anaconda
[[ -z $TMUX ]] || conda deactivate; conda activate base       #   + TMUX fix
export PATH="/opt/bin:$PATH"                                  # <-- personal stuff
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"            # <-- MacPorts
export PATH="/opt/local/libexec/gnubin:$PATH"                 # <-- Coreutils
source "$HOME/venvs/base/bin/activate"                       	# <-- Activate the Python
# }}}

# $MANPATH {{{
# export MANPATH="/usr/local/man:/usr/share/man:$MANPATH"
# export MANPATH="/opt/share/man:/opt/local/share/man:/opt/local/libexec/gnubin/man:$MANPATH"
# export MANPATH="$HOME/.fzf/man:$MANPATH"
# export MANPATH="$MANPATH:/opt/anaconda3/man:/opt/anaconda3/share/man"
# }}} no need, man smart, man good, if set, man breaks in tmux

# ZSH init {{{
export ZSH="$HOME/.zsh"
ZSH_CACHE_DIR="$ZSH/cache"
# fpath=($ZSH/functions $ZSH/completions $fpath)

source $ZSH/options.zsh
source $ZSH/keybindings.zsh
source $ZSH/completions.zsh
source $ZSH/aliases.zsh
source $ZSH/functions.zsh
source $ZSH/prompt.zsh
# }}}

# Plugins {{{
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# zinit ice as"completion" mv"comp* -> _exa"; zinit snippet 'https://github.com/ogham/exa/blob/master/contrib/completions.zsh'
zinit ice as"completion" mv"hub* -> _hub"; zinit snippet '/opt/local/share/zsh/site-functions/hub.zsh_completion'
# zinit ice as"completion"; zinit snippet 'https://github.com/rebelot/BioTools/blob/master/schrodinger_scripts/_schrun'
zinit ice as"completion"; zinit snippet 'https://github.com/malramsay64/conda-zsh-completion/blob/master/_conda'
zinit ice as"completion"; zinit snippet 'https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker'
zinit ice mv"zsh_completion.tpl -> _pandoc" as"completion"; zinit snippet 'https://gist.githubusercontent.com/doronbehar/134d83ae75309182d9fad8ecd7a55daa/raw/665108d3d4aa72f978fee1de10401e52e4cc54b6/zsh_completion.tpl'
# zinit ice as"completion"; zinit snippet /opt/src/nnn/scripts/auto-completion/zsh/_nnn
zinit load hlissner/zsh-autopair
zinit ice svn; zinit snippet OMZ::plugins/pip
zinit load bric3/oh-my-zsh-git
# zinit load srijanshetty/zsh-pandoc-completion
zinit ice blockf; zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting
# }}}

# plugin Opts {{{
# omg_prefix=" %{%B%F{white}%}%{%f%k%b%}"
omg_suffix=" %{%B%F{white}%} %{%f%k%b%}"
is_a_git_repo_symbol=" "
has_modifications_symbol=
has_modifications_color="%F{yellow}"
has_untracked_files_symbol=
ready_to_commit_symbol=
should_push_symbol=
detached_symbol=
print_unactive_flags_space=false
#                  
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap"
# export FZF_CTRL_T_OPTS=""
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_COMMAND="fd --follow --hidden --color=always --ignore-file=$HOME/.gitignore"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="$(echo \
"--ansi \
--no-height \
--preview '[[ \$(file --mime {}) =~ directory ]] && tree -C {} || { [[ \$(file --mime {}) =~ image ]] && catimg {}; } || { [[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file; } || bat --color=always --style=numbers,changes,snip {}' \
--preview-window wrap:hidden \
--border --margin=0,2 \
--bind 'ctrl-o:toggle-preview' \
--bind 'tab:down' \
--bind 'btab:up' \
--bind 'ctrl-z:toggle' ")"
# }}}

# User configuration {{{

# prompt
export PS1="$prompt_2short" # Set in $ZSH/prompt.zsh
export RPROMPT='$(oh_my_git_info)'

# ls colors
export CLICOLOR=1
autoload -U colors && colors
# export LSCOLORS="Gxfxcxdxbxegedabagacad"
# export LSCOLORS=ExFxBxDxCxegedabagEgGx
# eval "$(dircolors -b)" # coreutils tool, exports LS_COLORS moved in $ZSH/completions.zsh

# History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000
export HISTFILESIZE=-1

# programs env opts
export SCHRODINGER="/opt/schrodinger/suites2021-1"
export SCHRODINGER_ALLOW_UNSAFE_MULTIPROCESSING=1 #FUCK OFF
export PYMOL4MAESTRO="/opt/anaconda3/envs/pymol/bin/"
# export ILOG_CPLEX_PATH="/Applications/IBM/ILOG/CPLEX_Studio128"
# export JULIA_PKGDIR="/Users/laurenzi/.julia"
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export SCHRODINGER_SCRIPTS="$HOME/usr/src/schrodinger_utils/scripts"
export BIOTOOLS="$HOME/usr/src/BioTools"

# language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export PAGER=less
export VISUAL=nvim
export LESS=-R
# export MANPAGER=most

# Compilation flags
# export CPPFLAGS="-I/opt/local/include"
# export LDFLAGS="-L/opt/local/lib"
# export DYLD_LIBRARY_PATH="/usr/local/cuda/lib:$DYLD_LIBRARY_PATH"
# export QT_API="pyqt5"
# export CXX="/opt/local/bin/clang++"
# export CC="/opt/local/bin/clang"

#XCODE CTL SOURCES
# /Applications/Xcode.app/Contents/Developer
# /Library/Developer/CommandLineTools
# e.g.: xcode-select --switch /Library/Developer/CommandLineTools

# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# XDG
export XDG_CONFIG_HOME="$HOME/.config/"

# }}}

# Functions {{{

function melakappa {
    if [ $# -eq 0 ]; then
        echo "usage: melakappa Folder_Name"
    else
        mkdir -p ~/Jessicah/"$1" && mount_afp -i afp://$jessicah/"$1" ~/Jessicah/"$1"
    fi
}

function deskhide {
    local state
    state=$(defaults read com.apple.finder CreateDesktop)
    if $state; then
        defaults write com.apple.finder CreateDesktop false; killall Finder
    else
        defaults write com.apple.finder CreateDesktop true; killall Finder
    fi
}

function google {
    open "https://www.google.com/search?q=$*"
}

function lessc {
  pygmentize -O style=gruvbox -f terminal16m -g $1 | less
}

function tedit {
  tmux splitw 'zsh -lic "nvim "'$@'; read'
}

function cythonsetup {
  local exts=("$@")
  cat << EOF > setup.py
from setuptools import setup
from Cython.Build import cythonize

extensions = "${exts[@]}".split()
setup(
    ext_modules = cythonize(extensions, language_level = "3")
)
EOF
  bash -c 'read -p "Build? [y/n] " input
  if [[ $input = "y" ]]; then 
    python setup.py build_ext --inplace
  fi'
}

function pman {
  tmux display-popup -KR "man $@"
}
# }}}

# Aliases {{{
# see $ZSH/aliases.zsh

# alias juliapro=/Applications/JuliaPro-1.0.1.1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia
# alias julia=/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia
# alias licmoe="lmutil lmstat -c /Applications/moe2018/license.dat -a"
alias licdes="licmae | grep -A 3 DESMOND_GPGPU"
# alias valve.py=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/valve.py
alias vmd='/Applications/VMD\ 1.9.4a51-x86_64-Rev9.app/Contents/MacOS/startup.command'
# alias spritz="~/Desktop/tommy/nsfw/spritz.py"
alias fz="cd \$(z | awk '{print \$2}' | fzf)"
alias tflip='echo "(╯°□°)╯︵ ┻━┻"'
alias schrenv=". ~/venvs/schrodinger.ve/bin/activate"
alias clock='tty-clock -c -f %d-%m-%Y'
alias vim=nvim
alias debugpy="$HOME/venvs/debugpy/bin/python -m debugpy"
alias pudb='python -m pudb'
alias ptpy='ptipython'
alias vxl='/opt/VirtualGL/bin/vglconnect -s xlenceVPN'
alias pymol='/opt/anaconda3/envs/pymol/bin/pymol -xq -X 400 -Y 20 -W 800 -H 800 -d "cd $(pwd)"'
# }}}

# compinit / compdef {{{
autoload -Uz compinit
compinit -i
zinit cdreplay -q
# }}}

# other sources  {{{
# source /opt/gromacs-2018.4/bin/GMXRC
# source /opt/local/share/tldr-cpp-client/autocomplete/complete.zsh
source /opt/local/etc/profile.d/z.sh
source ~/.fzf.zsh
#test -e "$HOME/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# }}}

# Remove duplicates from PATH (Unique)
typeset -U path

# MANPATH Guard
unset MANPATH

# zprof

# vim:set et sw=2 ts=2 fdm=marker:
