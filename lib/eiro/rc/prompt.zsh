export PS1="[%T] %n@%M%b:%d
> "

precmd/git () {
    local up="$(shush2 git log -1 --format='%d')"
    [[ -n $up ]] && print "$up + $( shush2 git status -s |wc -l ) modifs"
}

true && precmd () {
        export PS1="%T %n@%M%b:%~ $( print "\e[7;31m$(
            (( $+TMUX )) || print INSECURE
        ), rt: $( is_installed precmd/n2 && shush2 precmd/n2) \e[7;36m$(
            precmd/git
        )\e[0m
> ")"
}
