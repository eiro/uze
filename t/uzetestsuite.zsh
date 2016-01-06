uze devel/TAP :all 
uze awk
uze ldap
uze sympa

prove/awk () {
    awk/new lol go to hell -- -F'[\\\\ ]'
    got=$( lol '{ print $to }' <<< 'go to\hell' )
    is $got to \
    "awk/new working"
}

prove/sympa () {

    eval $(sympa/lb/let di-tous-request@unistra.fr )

    note "lb/let from the email addr di-tous-request@unistra.fr"
    test $list = di-tous    ; ok "lb/let set \$list to '$list'"
    test $bot  = unistra.fr ; ok "lb/let set \$bot to '$bot'"

    note "lb from the path foo/bar"
    sympa/lb foo/bar
    test $list = bar ; ok "lb set \$list to $list"
    test $bot  = foo ; ok "lb set \$bot to $bot"

    note "lb from the bareword bar"
    sympa/lb bar

    test $list = bar ; ok "lb set \$list to $list"
    test -z bot      ; ok "bot is unset"

    local from='

foo/bar:owner
foo/bar:email foo
foo/bar:gecos foo dudu
foo/bar:
foo/bar:editor
foo/bar:email bar
foo/bar:gecos bar tabac
foo/bar:
foo/bar:send nothing

'

    expected='foo/bar:owner:email foo
foo/bar:owner:gecos foo dudu
foo/bar:editor:email bar
foo/bar:editor:gecos bar tabac
foo/bar:send nothing'

    got="$( sympa/config/kv/stream <<<"$from" )"

    is "$got" "$expected" \
    "sympa/config/kv/stream correct"

}

suite () {
    prove/awk 
    prove/sympa
}

prove suite
