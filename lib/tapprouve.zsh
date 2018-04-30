tapprouve () {

    [[ ${1:-} == -h ]] && {
        l 'tapprouve t/*.tap > t.html'
        return
    }

    prove -m -Q \
    --formatter=TAP::Formatter::HTML \
    --source File "$@"
}
