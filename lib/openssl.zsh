openssl/getcert () {
    :| openssl s_client -connect \
        ${1?usage: $0 hostname [port=993]}:${2:-993} 2>/dev/null |
	sed -n '/BEGIN/,/END/p'
}

