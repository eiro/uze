# set ~p5 as the root of all your perl repositories
# in CPAN package formats (use a tool like dzil to do it)
# * ./lib # contains docs and perl libs
# * ./bin # apps

# then use p5/env/dev to make them all available

# p5/env/local to load the default local::lib env

# example from my ~/.zshenv:
# > hash -d p5=~/src/perl/5/lib
# > uze p5/env
# > p5/env/dev

# so now i can

# > cd ~p5
# > git clone git@github.com:eiro/p5-perlude.git perlude
#
# et voilà! libs as well as commands are available

export -UT PERL5LIB perl5lib
export PERL_LOCAL_LIB_ROOT PERL_MB_OPT PERL_MM_OPT

p5/env/dev () {
    perl5lib=( lib ~p5/*/lib(N) $perl5lib )
    path=( ~p5/*/{bin,script{,s}}(N) $path )
}

p5/env/local () { eval $( perl -Mlocal::lib ) }
