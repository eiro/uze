uze curl

renater/IPDs/url () 
    https://services-federation.renater.fr/metadata/renater-test-metadata.xml 
}

renater/IDPs/all () {
    renater/IPDs/url  |
        xargs curl -s |
        perl -lnE 'say $1 if /entityID="(.*?)"/'
}

renater/IDPs/running () {
    renater/IDPs/all  |
        curl/say/poke |
        it/said yes
}
