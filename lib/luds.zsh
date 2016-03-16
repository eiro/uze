uze ldap

luds () {
    : ${1:=-}
    m4 ldapquery "$@" | ldap/filter/minify }



