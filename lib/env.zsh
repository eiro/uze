# vim: ft=zsh sw=4 fdm=marker path+=~/bin
: <<'=cut'

=head1 env settings helpers

=head2 env/provides (boolean)

true if all the commands listed as argument are available

=head2 env/home

when testing a new technology (say 'gorslub' in this example), the basics
is to create a GORSLUB_HOME then add $GORSLUB_HOME/bin in your $PATH.

two weeks later, you'll forget about all the gorslub buzz but the settings
are remaining. env will do the basics for you only if the $GORSLUB_HOME exists.

=head3 warnings

=item

it *unshift* the path to overload system provided binaries

=item

it will keep existing variables untouched

=back

=head3 examples

    # some potential new places
    env/home GOPATH        ~/local/opt/go
    env/home GROOVY_HOME   ~/local/opt/groovy
    env/home GRAILS_HOME   ~/local/opt/grails
    env/home GEM_HOME      ~/local/lib/gems
    env/home PINTO_HOME    ~/local/opt/pinto

=cut

env/provides () { for __ { shush which $__ || return } }

env/home () {
    local var=$1 dir=${2:-${REPLY:?where is this place $1 ?}}
    # don't overide existing variable
    eval '(( $+'$var' ))' && return
    # don't update env if there is no dir
    [[ -d $dir ]] || return
    eval "export $var=${(qq)dir}"
    [[ -d $dir/bin ]] && path=( $dir/bin $path )
    true
}
