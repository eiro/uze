: <<'=cut'

=head1 tmux helpers

=head2 tmux/simple

ease the use of tmux simplest (and most common) usecases.
recommended alias: C<t>.

to list the names of existing sessions:

    t

to attach an existing session with a name starting with 'foo':

    t foo

to create a new session 'foo':

=cut

tmux/simple () {
    (( $+1 )) ||
        {tmux ls -F '#S'; return}
    shush tmux att -t $1 ||
        tmux new -s $1
}
