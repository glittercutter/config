# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/glit/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

##################################################################
# Aliases

# Auto extension
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s jpeg=feh
alias -s gif=feh
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz='aunpack'
alias -s xz='aunpack'
alias -s rar='aunpack'
alias -s zip='aunpack'
alias -s bz2='aunpack'
alias -s java=$EDITOR
alias -s h=$EDITOR
alias -s c=$EDITOR
alias -s cpp=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR
alias -s mpeg='mplayer'
alias -s mpg='mplayer'
alias -s flv='mplayer'
alias -s avi='mplayer'
alias -s mp4='mplayer'
alias -s wmv='mplayer'
alias -s pdf='evince'

# Normal aliases
alias copy='rsync -aP'
alias ls='/usr/bin/vendor_perl/ls++'
alias la='/usr/bin/vendor_perl/ls++ -AF'
alias grep="grep --color -n"
alias rename="rename -v"
alias mkdir="mkdir -p"
alias f='find | grep'
alias i='urxvtc &'
alias v='vim' 
alias vi='vim'
alias sv='sudo vim'
alias iv='urxvtc -e vim &'
alias fm='ranger'
alias nested_fluxbox='sudo /utils/nested_fluxbox.sh'
alias aurget='cd ~/aur; aurget'
alias pacman='sudo pacman'
alias netcfg='sudo netcfg'
alias halt='shutdown'
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias make='make -j12 2>&1 | tee /tmp/quickfix.err'
alias g++='g++ 2>&1 | tee /tmp/quickfix.err'
alias gcc='gcc 2>&1 | tee /tmp/quickfix.err'
alias quickfix='2>&1 | tee /tmp/quickfix.err'
alias synctime='sudo /home/glit/utils/synctime.sh'
alias du='du -h'
alias df='df -h'
alias mk='make -j12'
alias connect='sudo ~/.utils/connect_to_network.sh midget_in_space'
alias brasero='dbus-launch brasero'
alias ssh='TERM=linux ssh'
alias gvim='urxvt -e vim'
alias dev='~/utils/start_dev.sh'
alias dus='~/utils/dus.sh'
alias fileserve='python2 -m SimpleHTTPServer 8000'

# cd
alias minimal='cd /data/dev/project/game/minimal_fps/build_nix_debug; urxvt -cd /data/dev/project/game/minimal_fps/src -e vim &'

source /home/glit/.nicoulaj.zsh-theme
