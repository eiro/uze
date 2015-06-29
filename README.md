# uze zsh (the way you use the other dynamic langages)

## motivations

what you miss the most when coming from a dynamic langage to zsh is the
ecosystem: some conventions and tools to share, document and test your code.

The testing part is very important as your zsh scripts relies on incompatible
tools which silently misbehave at runtime (GNU core utils, BSD tools, 9base
...).

However, zsh builtins comes with the hability to 

- have namespaces 
- embed documentation
- generate TAP

we just need tools and conventions to make this ecosystem lives. 

## examples

well ... this repo is full of examples but you can see the
[devel/TAP](https://github.com/eiro/uze/blob/master/devel/TAP) module because

- it's a good example of how i write things for the moment
- testing is something you probably miss when you come from perl :) 


if you want to see a test suite,
please have a look on the one i started to write to
[test my env](https://github.com/eiro/rcfiles/blob/master/env_test.zsh) to be
ready to use. 

# Documentation

you can use `perldoc` to read the command of any `uze` module, eg.

    perldoc ~/bin/uze/uze

an online documentation (poor rendering for the moment) is available on [my
github page](http://eiro.github.com/uze/index.html). it is generated using
this script:

    cat <( print "# uze documentation\n\n" )\
        uze \
        <( print "# uze\n\n" )\
        **/*~uze~*.md(.)|
            pod2markdown|
            sed ' s#^\\\*#*#
                  s,^#,##,
                ' |
            tee /tmp/podmds |
            pandoc --template=bootstrap > ~/www/e/uze/index.html

# Notes (for slides?)

my experience

- other shells (rc, mksh, tcsh, bash, ..)
- dynamic langages w/ REPL (zoidberg, perlude, tcl, ...)
- fresh starts (elvish, ...)

conclusion

- no silver bullet (who knew!)
- zsh does great

comparing to other "dynamic langages", 3 problems 

## number 1: super ugly syntax

due to 

- history, compatibility
- the way shells work

zsh works great

- new default behave (arrays,...)
- bridges to past ( $=, ...)

## number 2: underlying toolchains

- no comprehensive documentation
- incompatibility between toolchains (gnu coreutils, 9base, bsd utils, ...)
  w/ all those silent misbehave at runtime :)

## number 4: lost culture

- good parts ignored
- bad parts exagerated
- ignorance became standard
- no ecosystem to share, document and test

zsh do not compete dynamic langages, it completes them. we should

## uze

zsh is not the best shell, it's the ugliest dynamic langage. let's build
an ecosystem for it.

it already have

- have namespaces 
- embed documentation
- generate TAP

we need conventions

- best defaults (warncreateglobal, nounset, ...)
- extra keywords? (shush, fill, ... )
- conventions to install modules

and tools on top of those conventions

uzu 

## random thoughts

- first attempt of it was "zen" (Zsh Extension Network) from the members of 
  the `#zshfr@freenode`
- oh-my-zsh is about tunning, uze is about extending. i hated it one day long

# Basics

By strong convention, a module is file 

- available somewhere in your `$PATH`
- named exactly against the namespace or prefixed with `uze`
- defining functions that are prefixed with the namespace at least

## write a module

- read the `PATH_DIRS` section from the `zshoptions` man
- create a `uze` directory in wherever you like in your `$path`

now you can use and create modules using conventions. in this documentation, i
assume `~/bin/uze` is a directory and you added those lines in your `~/.zshenv`. 

    setopt pathdirs
    path+=( ~/bin/uze )

now you can create a file ~/bin/uze/very/long/namespace` which contains
all your functions related to your `very/long/namespace`. for exemple 

    very/long/namespace/hello () {
        print "hello ${1:-world}"
    }

    very/long/namespace/legendary () {
        print "legeeeeeeeendary !!!"
    }

    very/long/namespace/what_u_said () {
        print "i said ... wait for it ... legeeeeeeeendary!"
    }

you can also use an anonymous function to use a namespace in the function name

    function {
        $1/hello () {
            print "hello ${1:-world}"
        }

        $1/legendary () {
            print "legeeeeeeeendary !!!"
        }

        $1/what_u_said () {
            print "i said ... wait for it ... legeeeeeeeendary!"
        }
    } very/long/namespace

when writting functions, note that expected options are
(you can protect misbehaviors using setopt localoptions)

    braceccl
    extendedglob
    pathdirs
    nounset
    warncreateglobal

# use a module

to use those functions, you can now write anywhere from the command line or
your scripts

    . uze/very/long/namespace
    very/long/namespace/hello
    very/long/namespace/legendary
    very/long/namespace/what_u_said

in real live however, i use aliased namespaces

    ns=very/long/namespace
    . uze/$ns
    $ns/hello
    $ns/legendary
    $ns/what_u_said

# proposed coding style (for maintainers of uze repos)

- use anonymous functions and local variables to avoid the main namespace
  polution.
- use alternative syntax instead of the historical one (looks so much better)

    for f (*gz) gzip $f

    # and not the rubish

    for f in *gz; do
        gzip $f
    done

- it is recommended to improve reliability by making zsh more complaining

    setopt warncreateglobal nounset errreturn

- as well as easier to use

    extendedglob braceccl

- read "true in the nutshell" and unleash its power

    enable_ssh=true
    $enable_ssh && act_with_ssh

    instead of 

    enable_ssh=1

    [[ $enable_ssh == 1 ]] && act_with_ssh

- document using perlpod and noop (`:`)

    : << '=cut'

    =head1 now you can use perldoc

    please read the perldoc and perlpod mans to understand more

    =cut

# future

- any chance to use `zcompile`?
- use m4 macros to work around the ugliest parts of shellscripting?

