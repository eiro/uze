: << '=cut'

=head2 debian/repo/update

Rewrite the C<Packages.gz> of the current directory

=cut

debian/repo/update () {
    dpkg-scanpackages . |
        gzip -c9 > Packages.gz
}
