# vim: ft=zsh sw=4 fdm=marker path+=~/bin
# setting env for various programs


# are the commands passed as argument ready to use ? 
# return false instead
# usage: is_installed java fill osiris/wifi
is_installed () {
    local e
    for e { shush which -w $e || return }
}

# * does anyone know how to make CLASSPATH work for real ?
#   i tried all kind of classpath like 
#
#     * ~/local/jar/*jar
#     * ~/local/jar/\*
#     * ~/local/jar/ 
#
#   none of them seems to work.
#
# also: time to use nailgun: 
# http://www.martiansoftware.com/nailgun/quickstart.html

() {
    is_installed java || return
    local cmd jar
    for cmd jar (
        plantuml plantuml.jar
        ditaa    ditaa0_9.zip 
        ) { eval $cmd' () { java -jar '$HOME'/local/jar/'$jar' "$@" }' }

    # && {
    #     # export -UT CLASSPATH classpath
    #     # local -a j;
    #     # j=( ~/local/jar(N) )
    #     # classpath+=( $^j/\* )
    # } 

}






# when you compile tools by yourself (or just untar a ball somewhere)
# it is common to export a root variable and update the path 
# with the bin subdir (if it exists). new_place does it for you. 
#
# warnings:
#
# * it *unshift* the path to overload system provided binaries
# * it don't override existing variables
# * it does nothing if the declared path doesn't exist

new_place () {
    local var=$1 dir=${2:-${REPLY:?where is this place $1 ?}}
    # don't overide existing variable
    eval '(( $+'$var' ))' && return
    # don't update env if there is no dir
    [[ -d $dir ]] || return
    eval "export $var=${(qq)dir}"
    [[ -d $dir/bin ]] && path=( $dir/bin $path ) 
    true
}

# some potential new places 
new_place GOPATH        ~/local/opt/go
new_place GROOVY_HOME   ~/local/opt/groovy-1.8.6
new_place GRAILS_HOME   ~/local/opt/grails-3.0.4
new_place GEM_HOME      ~/local/lib/gems 
new_place PINTO_HOME    ~/local/opt/pinto


: ~/local/opt/clojurescript(Ne:'
    new_place CLOJURESCRIPT_HOME && classpath+=(
        $REPLY/clojure.jar(N)
    )
':)

# if present, loads the clojure profile (as provided by arch for example)  
: /etc/profile.d/clojure.sh('Ne:source $REPLY:') 

# this should be a separate file
# self explained ? 
path=(
    ~/local/opt/vim/bin(N)
    ~/bin(/N)
    ~/.cabal/bin(N)
    ~/.rvm/bin(N)
    ~/local/vendor/bin(/N)
    /usr/local/bin(/N)
    ~/src/got/bin(N)
    $path
)

# create a ditaa command if the jar is presen 
function () {
    [[ -e $1 ]] &&
        eval "ditaa () { java -jar $1"' "$@" }'
} ~/local/opt/ditaa/ditaa0_9.jar 

# perl6 {{{ 

path+=( ~/local/opt/rakudo/current/install/bin(N) )
hash -d p6=~/src/perl/6/lib
export -UT PERL6LIB perl6lib $(perl6 -e '$*DISTRO.cur-sep.say')
p6_reload_lib () {
    perl6lib=( lib ~p6/*/lib(N) $perl6lib )
    path=( ~p6/*/{bin,script{,s}}(N) $path )
}
p6_reload_lib 

# }}}