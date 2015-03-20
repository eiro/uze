: <<'=cut'

=head1 awk tools

=head2 awk/new

wraps awk with named fields

    . uze/awk
    awk/new apwd login pwd uid gid gecos home shell -- -F: 
    getent passwd | apwd '$login == "root" { print $shell }'


=cut

awk/new () {
    typeset -a fields extra
    local name=$1
    shift
    local bound=$argv[(I)--] 
    if (( bound )) {
        fields=( $argv[1,bound-1] ); extra=( $argv[bound+1,#argv] )
    } else { fields=( $argv ); extra=() }
    local i
    for i ( {1-$#fields} ) fields[i]=-v$fields[i]=$i
    eval "$name () { awk $fields ${(q)extra} \$@ }"
} 

