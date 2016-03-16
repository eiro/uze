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

() {
    $1/search () { lynx/dump "http://annuaire.unistra.fr/chercher" "$@" }
    $1/filter/cards () {
        perl -lnE 'print if m{ ^\[\d\][^&]+ $ }x ...  m{ ^\s*$ }x' }
    $1/filter/emails () {
        sed -nr '
            /Informations complémentaires/ {q}
            /@/ { s/.*]//p }
        '
    }

    local f
    for f (cards emails)
        eval "$1/$f () { $1/search "'"$@"'" | $1/filter/$f }"
} $__PACKAGE__
