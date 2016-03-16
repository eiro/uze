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
ff () { find "$@" -type f }

alias cc='gcc -pedantic -Wall -Werror -std=c99'
alias nslatex='latex -interaction=nonstopmode'

ssh/fp () {
    local host=${1:?forwarder host} port=${2:?port to forward} target=${3:-localhost}
    shush2 lsof -i:$port || ssh -fNL ${port}:$target:${port} $host
}

getent/service/port () {
    echo ${${"$(
        getent services ${1:?service spec (examples: ldaps ldaps/tcp 636/tcp)}
    )"##* }%/*}
}

dot2 () {
    if (( $+2 )) {
        local format=$1 f=$2
        shift 2
        # todo: add all supported formats
        [[ $format == (sv|pn)g ]] || {
            print -u2 invalid output format $format
            return 1 
        }
        dot "$@" -T$format -o $f:t:r.$format $f 
    } elif (( $+1 )) {
        local file=$1
        shift
        dot "$@" -T$file:e -o $file
    } else {
        print -u2 'usages:'
        print -u2 'dot2 outputformat inputfile'
        print -u2 'dot2 outputfile'
    }
}
