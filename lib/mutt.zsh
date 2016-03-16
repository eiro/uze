mutt/draft () {
    local draft=$1
    shift
    mutt -H ~/.mutt/dratfs/$draft "$@" 
}

mutt/account () { mutt -F ~/.mutt/accounts/$1 ${argv[2,-1]} }

matches-email-addrs () { perl -MEmail::Address -E '
    map say
    , map +( sprintf q(%s %s), $_->address, $_ )
    , map Email::Address->parse($_)
    , <>' "$@" }

