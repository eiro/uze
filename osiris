
# keep captive portal aware of your presence
# so you can close your browser without loosing connection
osiris/wifi () {
    local login passwd 
    < ~/.osiris_credentials | fill login passwd
    local url=https://wifi.pcap.u-strasbg.fr/bin/connexion 
    while {true} {shush wget --http-user=$login --http-password=$passwd $url}
}
