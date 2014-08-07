#!/bin/bash
# Requirement: bash >= 4.0 (because of the usage of $BASHPID)

sleep 1

# Wait for confirmation from the autostart script
cat ~/.config/herbstluftwm/start_with_rule_ready.fifo

spawn_with_rules()
{
    (
    # this rule also requires, that the client
    # sets the _NET_WM_PID property
    herbstclient rule once pid=$BASHPID maxage=10 "${RULES[@]}"
    exec "$@"
    ) &
}

#Exemple

# spawn an xterm with uname info, but not where the focus is
#RULES=( index='/' focus=off )
#spawn_with_rules xterm -e 'uname -a ; read'

# spawn an xterm in pseudotile mode
#RULES=( pseudotile=on focus=on )
#spawn_with_rules urxvt

RULES=( tag=0 )
spawn_with_rules firefox

RULES=( tag=9 )
spawn_with_rules urxvt -e ncmpcpp

#herbstclient load 1 '(split vertical:0.200000:0)'
#path=/data/dev/project/game/minimal_fps
#RULES=( tag=1 index=1 )
#spawn_with_rules urxvt -cd $path/src -e vim
#RULES=( tag=1 index=0 focus=on )
#spawn_with_rules urxvt -cd $path/build_nix_debug

#RULES=( tag=2 )
#spawn_with_rules urxvt -cd $path -e vim todo


# Fix background artifact on start
herbstclient floating toggle
herbstclient floating toggle
