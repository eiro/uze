: <<'=cut'

=head1 ldap/filter functions

=head2 minify

transform human readable version of an ldap query to a program readable one by
removing all extra spaces and line returns. so

    (| (uid=a)
       (uid=b)) 

is minified as 

    (|(uid=a)(uid=b))

=head2 oneOf

prepare 
    (|(uid=a)(uid=b))

=cut

ldap/filter/minify () {
    perl -MNet::LDAP::Filter -0 -nE '
    
        s/  (?(DEFINE)
            (?<ws_or_eol> [\v\h]+))

            ^ (?&ws_or_eol)
            | (?&ws_or_eol) $
        //xmsg;

        say Net::LDAP::Filter 
        -> new( $_ )
        -> as_string
    ' "$@"
} 
