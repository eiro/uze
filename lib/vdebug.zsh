komodo-debugger-settings () {
    perl5lib=(
    ~/local/opt/Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64/
    $perl5lib )
    export PERL5DB="BEGIN { require q(/home/mc/local/opt/Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64/perl5db.pl)}"
    export PERLDB_OPTS="RemotePort=localhost:9000"
    export DBGP_IDEKEY="whatever"
}
