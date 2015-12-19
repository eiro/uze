: <<'=cut'

=head1 osiris/wifi

keep captive portal aware of your presence by fetching the
wifi page every 1 seconds so you can close your browser
without loosing connection. 

=cut

osiris/wifi () {
    local login passwd 
    < ~/.osiris_credentials | fill login passwd
    local url=https://wifi.pcap.u-strasbg.fr/bin/connexion 
    while {sleep 1} {shush wget --http-user=$login --http-password=$passwd $url}
}
