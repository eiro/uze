whence/readlink () {
    eval $(
        whence -w $1 |
        sed  -rn 's/(.*): command$/readlink -e =\1/p'
    )
}
