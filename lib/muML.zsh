: <<'=cut'

=head1 micro Mailing-List format

when the first bareword of each lines is an email adress, everything else is up
to you.

so it can be a contact list, a list of data for a template placeholder, ...

=head2 T_/to

transform a muml stream to a To: field (usefull in mutt, for example)

=cut

muML/T_/to () {
    sed '
        s/$/,/
        s/^/  /
        1s/^  /To: /
        # $s/,$// # as it seems useless?
    ' "$@"
}

