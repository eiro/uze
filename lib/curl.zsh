uze it

curl/poke () { shush curl -fs --connect-timeout 1 ${1:-${REPLY:?no parameter supplied}} }
curl/say/poke () {
    local url="${1:-${REPLY?:-no parameter supplied}}"
    print "$( does_it curl/poke $url ) $url"
}

curl/tarx () {
    setopt localoptions xtrace
    local tarball=$1
    shift
    tar x "$@" $tarball
}

curl/mdtitle () {
    local url="${1:-it}"
    local title="$( curl -sL "$url" | grep -Poi '(?<=<title>)[^<]+' )"
    if ((!?)) { print "[$title]($url)" }
}

# uzu devel/TAP :all
# test/suite () {
#     got="$( url/mdtitle http://www.openbsd.org )"
#     is "$got" OpenBSD "OpenBSD title found" || note $got
# }
# prove test/suite


