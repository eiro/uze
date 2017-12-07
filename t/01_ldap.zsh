
# prove ldap_filters
# l=ldap/filter
# $l/or mail= toto tata tutu
# $l/or '' mail=toto uid=toto

uze devel/TAP :all

ldap_filters () {
    local l=ldap/filter
    got="$( seq 3 | $l/or- mail= )"
    expected="(|(mail=1)
(mail=2)
(mail=3))"
    [[ "$got" == "$expected" ]]; ok "or- with one argument"

    got="$( print -l a=1 b=2 c=3 | $l/or- )"
    expected="(|(a=1)
(b=2)
(c=3))"
    [[ "$got" == "$expected" ]]; ok "or- without argument"

    got=$( $l/minify <<< "
        (| (uid=a)
           (uid=b))" )
    expected="(|(uid=a)(uid=b))"
    is "$got" "$expected"       \
    "ldap minification working" ||
        note "ldap/filter $got"


}

prove ldap_filters
