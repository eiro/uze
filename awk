: <<'=cut'

=head1 awk tools

=head2 awk/new

wraps awk with named fields

    . uze/awk
    awk/new apwd : login pwd uid gid gecos home shell 
    getent passwd | apwd '$login == "root" { print $shell }'


=cut

awk/new () {
    local name=$1 sep=${(q)2} params='"$@"'
    shift 2
    typeset -a fields vars
    vars=( -v$^fields )
    eval "$name () { awk -F$sep $vars $params }"
} 

