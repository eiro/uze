: <<'=cut'

=head1 sympa administration library

Those functions ease the help of the sympa administration

=head2 Configuration

those are the lines you need to run before using the API (for exemple, by
sourcing them from C<.zshenv>).

    typeset -A SYMPARC
    uze sympa
    SYMPARC=(
       arc_path $( sympa/rc/get arc_path /etc/sympa/wwsympa.conf )
       queueoutgoing $( sympa/rc/get queueoutgoing /etc/sympa/sympa.conf )
       arc_path  $( sympa/rc/get arc_path /etc/sympa/wwsympa.conf )
       root      ~/expl
       script    /usr/lib/sympa/bin/sympa.pl
       etc       /etc/sympa
       bot       example.com
    )


=head2 Functions

=head3 sympa/rc/get

get a single key stored in a single line in a sympa config file
example

    sympa/rc/get queueoutgoing /etc/sympa/sympa.conf

=cut

sympa/rc/get () {
    local key=${1:?key in the file} file=${2:?file to seek the key}
    sed -n "s/^$key\s*//;T;p;q" $file
}

: <<'=cut'
=head3 sympa/rc/dump

dump the SYMPARC structure a readable, evaluable way

=cut

sympa/rc/dump () {
    local k v
    for k v ( ${(kv)SYMPARC} ) print "$k $v"
}


: <<'=cut'

=head3 sympa/archived

ask archived to remove or rebuild a list given its address

    sympa/archived remove old-list
    sympa/archived remove old-list@exemple.com

=cut

sympa/archived () {
    local cmd=$1 addr=$2
    [[ $cmd == re(build|move) ]] || {
	warn "$cmd isn't a valid command"
	return
    }
    [[ $addr == *@* ]] || addr=$addr@$SYMPARC[bot]
    touch $SYMPARC[queueoutgoing]/.$cmd.$addr
}


# list all text files from an archive
# example:
#    sympa/arc/txt/ls list@example.com | while {read file} {
#	local enc=$( file --mime-encoding $file )
#	[[ $enc == *utf-8 ]] || {
# 	    recode $enc..utf-8 $f
# 	    sed -i "s#charset=$enc#charset=utf-8#g" $source
# 	}

sympa/arc/txt/ls () { find $SYMPARC[arc_path]/${1:?address of the list}/*/arctxt/ -type f }

sympa/bot/ls () { (cd $SYMPARC[etc] && print -l */robot.conf(:h)) }

# better ?
# SYMPA_MATCHES_BOTS="/etc/sympa/*.(eu|fr)(/:t)"
# ls_bots () { print -l $~SYMPA_MATCHES_BOTS }

# give the path of the list directory
# (whatever form you provide in entry)
# examples:
# cdl () { cd $(sympa/list/path $1) }
# vil () { vim $(sympa/list/path $1)/config }
# those are the same (asuming example.com is the default bot)
# cdl managers
# cdl managers@example.com
# cdl example.com/managers

sympa/lb () {
    if   [[ $1 == */* ]] { IFS=/ read bot list <<< $1 } \
    elif [[ $1 == *@* ]] {
        IFS=@ read list bot <<< $1
        list=${list%-(request|editor|owner)}
    } \
    else { list=$1 }
}

sympa/lb/let () { print "local list bot; sympa/lb $1" }

sympa/list/tarball () {
    local list bot
    sympa/lb $1
    local addr=$list@${bot:=$SYMPARC[bot]}

    ( set -e

        cd $SYMPARC[root]/$bot
        tar cz $list

        cd $SYMPARC[arc_path]
        [[ -e $addr ]] && tar cz $addr
    )
}

sympa/list/path () {
    eval $(sympa/lb/let ${1:?list name missing})
    [[ -n $bot ]] && print $SYMPARC[root]/$bot/$list || {
	[[ $list == */* ]] &&
	    print $SYMPARC[root]/$list ||
	    print $SYMPARC[root]/${SYMPARC[bot]}/$list
    }
}

sympa/bot/cd      () { cd $SYMPARC[bot]/$1 }


sympa/list/mv () {
    local new robot
    IFS=@ read new robot <<< ${2:?usage: mv old new}
    : ${robot:=$SYMPARC[bot]}

    local old=$1
    [[ $old == *@* ]] || old=$old@$SYMPARC[bot]

    $SYMPARC[script] \
	--rename_list=$old      \
	--new_listname=$new     \
	--new_listrobot=$robot
}

sympa/list/close () {
    local list=${1:?addr of the list to close}
    [[ $list == *@* ]] || old=$list@$SYMPARC[bot]
    $SYMPARC[script] --close_list=$list
}

sympa/subscribers/dump/cat () {
    sympa/subscribers/dump/prepare $1
    local p=$( sympa/subscribers/dump/path $1 ) && cat $p
}

sympa/subscribers/dump/path () {
	: ${1:?the name of the list is expected as argument}
	local user domain
	IFS=@ read user domain <<< "$1"
	echo ~/expl/${domain:-$SYMPARC[bot]}/$user/subscribers.db.dump
}

sympa/subscribers/dump/prepare/now () {
    # typical usage is: cat $( sympa/subscribers/dump/prepare/now staff )
    local list=${1:?the name of the list is expected as argument}
    [[ $list == *@* ]] || list=$list@$SYMPARC[bot]
    sympa --dump=$list
    sympa/subscribers/dump/path $list
}

sympa/subscribers/dump/prepare/when () {
    # typical usage is: cat $( sympa/subscribers/dump/prepare staff@example.com )
    local list=${1:?the name of the list is expected as argument}
    shift
    local p=$( sympa/subscribers/dump/path $list )
    find $p "$@" && sympa --dump=$list
    $p
}

sympa/subscribers/dump/filter/count  () { grep -c '^e' "$@" }
sympa/subscribers/dump/filter/emails () { sed -n 's/^email //p' "$@" }

sympa/config/kv/get    () { grep \^ $~1| kvc/stream }
sympa/config/kv/stream () {
    perl -wlnE '
        state $r = "";
        if    (/^.*:\s*$/     ) { $r=""; next }
        elsif (/^.*:(\w+)\s*$/) { $r="$1:" }
        else  { print if s/:/:$r/ }
    '
}

