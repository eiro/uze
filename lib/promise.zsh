: <<'=cut'

=head1 Promises in zsh

=head2 promise/new $args

promises are process launched in background
to produce a bunch of files in C<$PROOT>.

1> out 
2> err
   ret

=cut

promise/mkdir () {
    mktemp -d\
    ${PROOT?the PROOT variable must be set according to the documentation}/XXXXXXXXXXXXXX
}

promise/new () {
    local __promise_root=$( promise/mkdir )
    { cat "$*" |zsh >$__promise_root/out 2>$__promise_root/err
        print $? > $__promise_root/ret
    } &
    print $__promise_root
} 

promise/mix () {
    local __promise_root=$( promise/mkdir)
    { cat "$*" |zsh &>$__promise_root/out 
        print $? > $__promise_root/ret
    } &
    print $__promise_root
} 

promise/append () {
    local __promise_root=${PROOT}$( promise/mkdir)
    { cat "$*" |zsh &>$__promise_root/out 
        print $? > $__promise_root/ret
    } &
    print $__promise_root
} 

