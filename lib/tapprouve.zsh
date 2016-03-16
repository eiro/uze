tapprouve () {
    # tapprouve t/*.tap > t.html
    prove -m -Q \
    --formatter=TAP::Formatter::HTML \
    --source File "$@"
}
