: <<=cut

=head1 awk tools

=head2 awk/cols 

# examples:
# awk/cols PWD_FIELDS login pwd uid gid gecos home shell 
#      creates or update a PWD_FIELDS list so you can use it as 
#   awd () { awk -F:  -v$^PWD_FIELDS "$@" }  
# when awk/new creates a command 
#  $1 is the name of the new command 
#  $2 is the separator (-F)
# th
# awk/new awd : login pwd uid gid gecos home shell  

getent passwd | awd '
    $shell ~ /zsh/ { print $login" uses "$shell" as shell "}
'

=head1 SSBP

you don't do that in your favorite language either, so please use good
practices instead of blaming shell for its unreadability.

=head2 aerate 

=head3 try to avoid multiple expressions in a line


    it is hard to see 3 commands in one lines

        getent passwd | cut -f1,7 -d: | grep zsh  

    and pipe can be used as line continuation so it's much cleaner
    to write 

        getent passwd     |
            cut -f1,7 -d: |
            grep zsh 

    backtricks can also be used to split on 
    to write 




=head3 break and indent lines when using pipe
 
    * when possible, use new lines in alien scripts

        getent 

        awk -F: 'BEGIN{x=12}/zsh/{print $1}' 


    perl -CSD -Mre=/xms -wsE '
        say $x
    ' -- -x=12




=head3 one-liners (awk, perl, ...)

=head2 use a separated line 

awk '/test/{print $1}' 



=head2 don't interpolate one-liners

write this

    perl -sw -E'
        say $x; say $x; say $x
    ' -- -x=12
12
12
12





=head1 SSBP2 awk named columns

when writing awk script, you must name your columns

=over

=item * 

=item *

=back
    
    * by interpolating a shell variable
    * make the script more readable, you

one of my SSBP is to name columns when using awk. as C<$> means "the value of
...", you often scratch your head to how what C<$7> could be. the solution is
to declare a variable named as the name of the column and set as the number of
the column. you shoud do that in the C<BEGIN> block so it can be done once and
forever.

so instead of 

    getent passwd | awk -F: '
        $7 ~ /zsh/ { print $1" uses "$7" as shell" }
    '

please write

    getent passwd | awk -F: '
        BEGIN { login=1; shell=7; }
        $shell ~ /zsh/ { print $login" uses "$shell" as shell" }
    ' 

and to make future usage easy, you should name all the available fields

    getent passwd | awk -F: '
        BEGIN {
            login=1;pwd=2;uid=3;gid=4;gecos=5;home=6;shell=7;
        }
        $shell ~ /zsh/ { print $login" uses "$shell" as shell" }
    '

Things are more maintainable then but how about the situation you have 


=cut

awk/cols () {
    local slot=$1; shift
    eval '(( $+'$slot' ))' || typeset -ga $slot
    local i=1 c
    for c { eval $slot+=$c=$[i++] }
}

awk/new () {
    local name=$1 sep=${(q)2} params='"$@"'
    shift 2
    typeset -a fields vars
    awk/cols fields "$@"
    vars=( -v$^fields )
    eval "$name () { awk -F$sep $vars $params }"
} 

