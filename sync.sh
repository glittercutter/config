#!/bin/sh

path=""

sy()
{
    in="$1"

    if [ ! -e "$in" ]
    then
        echo "WARNING: file '" $in "' does not exist"
        return
    fi

    out="./"$path"/"${in#$HOME/}

    # Create missing directory
    dir=`dirname "$out"`
    test -d "$dir" || mkdir -p "$dir"

    # Strip last directory if the input itself is a directory
    if [ -d "$out" ]; then out=${out%/*}; fi

    cp -r "$in" "$out"
}

path="nix"
sy "$HOME/.config/gtk-3.0/settings.ini"
sy "$HOME/.config/herbstluftwm"
sy "$HOME/.colours"
sy "$HOME/.zshrc"
sy "$HOME/.gtkrc-2.0"
sy "$HOME/.ncmpcpp/config"
sy "$HOME/.Xresources"
sy "$HOME/.xinitrc"

path="vim"
sy "$HOME/.vimrc"
sy "$HOME/.vim"
