: <<'=cut'

=head1 entry

transform a title read from stdin or in "$@" to an index entry in the blog
posts directories of eiro.github.io.

=cut

eiro/blog/entry () {
    local title
    [[ -n $argv ]] &&
        title="$*" ||
        read title
    local file=$( sed '
        s/[-:?_!+.@,()]/ /g
        s/[éè]/e/g
        s/[à]/a/g
        s/ \+/_/g
    ' <<< "$title" ).md
    date +"%FT%T+01:00 $file $title"
}
