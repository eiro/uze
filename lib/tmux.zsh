tmux/smart () {
    (( $+1 )) ||
        {tmux ls -F '#S'; return} 
    shush tmux att -t $1 ||
        tmux new -s $1
}


