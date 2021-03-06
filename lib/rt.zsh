# JARGON

# A rt_q format is a text representation of a rt query
# (see https://github.com/eiro/vim-rt-client)
#
# A $RT_WORKSPACE is just a directory with
# * some rt_q formated files
# * a .pull subdirectory with files to update them
#   (so $RT_WORKSPACE/stack will be updated by the
#   result of $RT_WORKSPACE/.pull/stack when you
#   launch rt/ws pull stack)

# CONFIGURATION
#
# * vim-rt-client must be installed in your vim &rtp in
#   a way vim ftdetects rt_q and rt_tk
# * $RT_WORKSPACE must be exported
# * the current file must be in `uze`
#


# goto $RT_WORKSPACE and launches subcommands
rt/ws () {
    (( $#@ )) || { cd $RT_WORKSPACE; return }
    local sub=$1; shift
    ( cd $RT_WORKSPACE && rt/ws/$sub "$@" )
}

# pull subcommand updates the content of any file in the workspace
rt/ws/pull () { zsh .pull/$1 > ${2:-$1} }

# edit a ticket queue from whereever you are
rt/ws/edit () {
    if (( $#@ )) { vim "$@" } \
    else { ls -F | U }
}

# pull *and* edit a queue

rt/ws/bn () { rt/ws pull $1 && rt/ws edit $1 }

# rt ls -s | rt/rt_q
# to format the result of a query as rt_q format
#
# rt ls -o -Created -s "$(
#     rt/tk/active Owner=mchantreux
# )" | rt/queue/rt_q

# rt_q formatter
# (see https://github.com/eiro/vim-rt-client)
# works with the a simple format like
#
# rt ls -l -o -Created -s "$(
#     rt/tk/active Owner=mchantreux
# )"

rt/rt_q () { sed '1{/^No/Q};s/:/ #/' }

# so commonly used i made a wrapper for
rt/tk/active () {
    print -f '%s
        and status!=resolved
        and status!=rejected
        and status!=stalled
    ' "$@"
}

rt/-query () { m4 rtquery - <<< "$*" }
