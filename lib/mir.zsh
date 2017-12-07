: <<'=cut'

=head1 MARC::MIR helpers

=head2 functions

=head3 mir/ed

is a sed alike filter for ISO2709 based on the perl MARC::MIR library. the first
element is a script that can use functions with 1 letter shortcuts

    r transform the C<$_> from raw to MIR structure (C<from_iso2709>)
    h returns a human readable dump of $_ (C<for_humans>)

=head3 mir/dump

just a shortcut to the C<mir/ed> script

    say h r

=head2 examples

how many records

    mir/sed 'END {print $.}' TR241R2265A001.RAW

how many records contains Bury ?

    mir/sed 'END {print $i} $i++ if /Bury/' TR241R2265A001.RAW

dump the first record containing bury

    mir/sed '/Bury/ and say h r and exit' TR241R2265A001.RAW

=cut

0=$__PACKAGE__

$0/ed () {

    # man perlrun to get all the informations.
    # -w use warnings
    # -nE script acts like sed -n script ($_ is the line)
    # -0x1d makes ISO2709 records to be lines (so they are streamed)

    perl -MMARC::MIR -w -0x1d -nE '
        sub r { $_ = from_iso2709 } # read
        sub h { for_humans }        # human
    '$1 $argv[2,-1]
}

$0/dump () { mir/sed "say h r" "$@" }
