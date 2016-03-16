ylint      () { perl -MYAML -e 'print Dump YAML::LoadFile("'"$1"'")' }
html_prove () { prove -m -Q --formatter=TAP::Formatter::HTML "$@" }
y2js       () { perl -MYAML -MJSON -0 -e "print(encode_json(YAML::Load(<>)))" }
js2y       () { perl -MYAML -MJSON -0 -e "print(YAML::Dump(decode_json(<>)))" }
textile () {
    perl -MText::Textile=textile -0 -we '
	$_ = Text::Textile->new;
	$_->disable_encode_entities("fuck,yeah!");
	print $_->textile( <> );
	# print textile <>
    '
}


rediff () { local f=$1; shift; vimdiff scp://$^@/$f $f  }
podish () { perldoc -o html "$@"  > ~/www/pod.html }
ff () { find "$@" -type f }

alias cc='gcc -pedantic -Wall -Werror -std=c99'
alias g=git
alias nslatex='latex -interaction=nonstopmode'


alias s=ssh
sz  ()  { s "$@" zsh  }
sm  ()  { s $argv[1] mysql "${(@)argv[2,-1]}" }

ssh/fp () {
    local host=${1:?forwarder host} port=${2:?port to forward} target=${3:-localhost}
    shush2 lsof -i:$port || ssh -fNL ${port}:$target:${port} $host
}

getent/service/port () {
    echo ${${"$(
        getent services ${1:?service spec (examples: ldaps ldaps/tcp 636/tcp)}
    )"##* }%/*}
}