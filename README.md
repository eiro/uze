# uze and share your zsh libs

use zsh 5.x or GTFO!

# what is it? 

uze isn't extra code, just the convention to share your zsh functions via git
repos named `uze` somewhere in your `$path` (you need to `setopt pathdirs` to
do that).

so in your repo, you can have a file named `a/very/long/namespace` in which
you can define a function `a/very/long/namespace/greetings`.

so now you can

    . uze/a/very/long/namespace
    a/very/long/namespace/greetings

or more idiomatically

    ns=a/very/long/namespace
    . uze/$ns
    $ns/greetings

by strong conventions:

* functions are named with a namespace
* namespaces are defined in the corresponding file of your repo 
  * the function foo/bar/hello must be declared in foo/bar
  * the file foo/bar MUST NOT declare functions in another
    namespace (like hello or f/hello)

## installation 

* use the `pathdirs` option
* choose a directory from your path where to clone your repo to
* name your local repo "uze"
* need more uze? add more `$path`

as example: at the very begining of your `~/.zshenv`, you can read:

    setopt pathdirs
    path=( $path ~/bin )

to install my repo, i just have to: 

    mkdir -p ~/bin
    cd $!
    git clone https://github.com/eiro/uze

now i can

    . uze/mir
    mir/sed .....

# proposed coding style (for maintainers of uze repos)

see
[unistra/annuaire](https://github.com/eiro/uze/blob/master/unistra/annuaire) as
a proposal to deal easily with namespaces.

reduce the potential conflicts by using long and informative namespaces, as
users are encouraged to use variables.

use alternative syntax instead of the historical one

    for f (*gz) gzip $f

    # and not

    for f (*gz) gzip $f


it is recommended to improve reliability by making zsh more complaining: 

    setopt warncreateglobal nounset errreturn

make zsh easier to use

    extendedglob braceccl

read "true in the nutshell" and unleash its power:

    enable_ssh=true

    $enable_ssh && {
        act_with_ssh
    } 

# todo

(any chance to use `zcompile`?)
