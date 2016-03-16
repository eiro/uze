js/minify () {
    perl -MLWP::Simple -MJavaScript::Minifier=minify -wE'
        print minify input => get shift
    ' $1
}

js/minify- () {
    perl -MJavaScript::Minifier=minify -0 -nwE'print minify input => $_'
}
