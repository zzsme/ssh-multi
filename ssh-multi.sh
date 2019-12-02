#!/bin/sh
# ssh-multi
# D.Kovalov, P.Brantsch
# Based on http://linuxpixies.blogspot.jp/2011/06/tmux-copy-mode-and-how-to-control.html
# Modified by johnko https://gist.github.com/johnko/a8481db6a83ec5ea2f37

# a script to ssh multiple servers over multiple tmux panes

printusage() {
    cat <<EOF
USAGE:
    $0 host [host]...
For each given host, this script creates an ssh session in a tmux pane.
The panes will be synchronized, so that they all receive the same keystrokes.
To reuse an existing tmux session, set the SSHMULTISESSION variable to the
name of that session.
EOF
}

starttmux() {
    SSHMULTISESSION=${SSHMULTISESSION:="ssh-multi-$$"}
    if [ $# -eq 0 ]; then
        printusage
        exit 1
    fi

    #exec &>/dev/null # mute stdout and stderr

    if tmux has-session -t "$SSHMULTISESSION"; then
        tmux new-window -t "$SSHMULTISESSION" "ssh $1"
    else
        tmux new-session -s "$SSHMULTISESSION" -d "ssh $1"
    fi
    shift
    for i in $* ; do
        tmux split-window -t "$SSHMULTISESSION" -h  "ssh $i"
        tmux select-layout -t "$SSHMULTISESSION" tiled
    done

    tmux select-pane -t "$SSHMULTISESSION:0"
    tmux set-window-option -t "$SSHMULTISESSION" synchronize-panes on
}

starttmux $*

if [ "x" != "x$TMUX" ]; then
    # we are running inside tmux
    tmux switch-client -t "$SSHMULTISESSION"
else
    # not running from inside tmux
    tmux attach-session -t "$SSHMULTISESSION"
fi
