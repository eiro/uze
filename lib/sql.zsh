sql/Quote ()  { print "'${(j:',':)${@//'/''}}'" }
sql/Args   () { print "('${(j:',':)${@//'/''}}')" }

sql/Proc   () {
    local proc_name
    if [[ - == $1 ]] {
	proc_name=$2
	typeset -a data
	while { read -A data } {
	    print "select ${proc_name}('${(j:',':)${(@)data//'/''}}');"
	}
    } else {
	proc_name=$1
	shift
	print "select ${proc_name}('${(j:',':)${@//'/''}}');"
    }
}

