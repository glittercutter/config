# Oh My Zsh options
zstyle ':omz:editor' keymap 'vi'
zstyle ':omz:editor' dot-expansion 'yes'
zstyle ':omz:*:*' case-sensitive 'no'
zstyle ':omz:*:*' color 'yes'
zstyle ':omz:terminal' auto-title 'no'
zstyle ':omz:load' plugin 'archive' 'git'
zstyle ':omz:prompt' theme 'sorin'
source "$HOME/.oh-my-zsh/init.zsh"

##################################################################
# Aliases

# Auto extension
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
alias -s pdf='zathura'

# Normal aliases
alias ls='ls --color=auto -F'
alias la='ls --color=auto -AF'
alias ll='ls --color=auto -lphF'
alias lla='ls --color=auto -lAphF'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias grep="grep --color -n"
alias mkdir="mkdir -p"
alias f='find | grep'
alias i='urxvtc &'
alias v='vim' 
alias vi='vim'
alias sv='sudo vim'
alias iv='urxvtc -e vim &'
alias fm='ranger'
alias wifi='sudo /utils/wifi.sh'
alias aurget='cd ~/aur; aurget'
alias pacman='sudo pacman'
alias reboot='sudo reboot'
alias halt='sudo halt'
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'

# command L equivalent to command |less
alias -g L='|less' 

# command S equivalent to command &> /dev/null &
alias -g S='&> /dev/null &'

# tty colour
/home/glittercutter/.colours/Colorshot_tty
