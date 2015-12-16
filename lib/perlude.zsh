perlude () {
    rlwrap -C perlude --complete-filenames --no-children \
        -H ~/.perlude/history \
        -f ~/.readline/abbr/perlude \
        -S "perlude> " \
        perl shell.pl
        #perl5i -wMDevel::SimpleTrace shell.pl
}

