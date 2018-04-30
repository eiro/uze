uze TAP :all
uze maildir

our_maildir_stuff () {

    # create a playground to build an inbox in
    local playground
    mktemp -d /tmp/TAP.MAILDIR.TEST.XXXX |
        read playground

    # the actual inbox
    local in=$playground/inbox

    maildir/build $in

    local \
        expected=$'cur\nnew\ntmp' \
        got="$( l $playground/inbox/*(/:toa))"

    expected "inbox is populated by maildir/build" || {
        l got= $got | TAP/note-
        l expected= $expected | TAP/note-
    }

}

prove our_maildir_stuff
