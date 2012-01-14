# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="tonotdo_1"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

##################################################################
# My aliases

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=geeqie
alias -s jpg=geeqie
alias -s jpeg=geeqie
alias -s gif=geeqie
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz='aunpack'
alias -s bz2='aunpack'
alias -s java=$EDITOR
alias -s h=$EDITOR
alias -s c=$EDITOR
alias -s cpp=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR
alias -s mpeg='mplayer'
alias -s flv='mplayer'
alias -s avi='mplayer'
alias -s mp4='mplayer'

# Normal aliases
alias ls='ls --color=auto -F'
alias la='ls --color=auto -AF'
alias ll='ls --color=auto -lphF'
alias lla='ls --color=auto -lAphF'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias grep="grep --color -n"
alias mkdir="mkdir -p"
alias f='find |grep'
alias c="clear"
alias dir='ls -1'
alias i='urxvt'
alias v='vim' 
alias vi='vim' 
alias iv='urxvt -e vim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias x='startx'
alias fm='ranger'
alias wifi='sudo /util/wifi_start.sh'
alias aurget='cd ~/aur; aurget'
alias pacman='sudo pacman'
alias reboot='sudo reboot'
alias halt='sudo halt'
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'

# command L equivalent to command |less
alias -g L='|less' 

# command S equivalent to command &> /dev/null &
alias -g S='&> /dev/null &'
