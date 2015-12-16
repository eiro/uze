: << '=cut'

=head1 query http://annaire.unistra.fr/chercher

is a form to query the University of Strasbourg Yellow Page
this uze provide wrappers and filters on it 

unistra/annuaire/search lynx dumps a result of a search

    parameters are 
    p: firstname (prenom)
    n: lastname  (name)
    s: structure name 

in most cases, you don't want the whole page, so we have helpers and filters:
unistra/annuaire/cards for complete informations about found people
unistra/annuaire/emails for just emails 

as example, you can find me with
unistra/annuaire/cards p marc m chant

=cut

uze lynx

function () {
    local m=$1
    shift

    $m/search () { lynx/dump "http://annuaire.unistra.fr/chercher" "$@" }

    $m/filter/cards () {
        perl -lnE 'print if m{ ^\[\d\][^&]+ $ }x ...  m{ ^\s*$ }x'
    }

    $m/filter/emails () { 
        sed -nr '
            /Informations complémentaires/ {q}
            /@/ { s/.*]//p }
        ' 
    }

    local f
    for f (cards emails)
        eval "$m/$f () { $m/search "'"$@"'" | $m/filter/$f }"
} ${0#uze/} "$@"
