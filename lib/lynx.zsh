lynx/dump () {
    local url="${1?i need at least an url to get}?" k v
    shift
    for k v { url="$url&$k=$v" }
    lynx -dump "$url"
} 
