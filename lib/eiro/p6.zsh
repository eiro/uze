path+=( ~/local/opt/rakudo/current/install/bin(N) )
hash -d p6=~/src/perl/6/lib
export -UT PERL6LIB perl6lib $(perl6 -e '$*DISTRO.cur-sep.say')
p6_reload_lib () {
    perl6lib=( lib ~p6/*/lib(N) $perl6lib )
    path=( ~p6/*/{bin,script{,s}}(N) $path )
}
p6_reload_lib 
