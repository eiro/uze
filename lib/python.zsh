python/start-project () {
    curl -sL https://github.com/pypa/sampleproject/archive/master.tar.gz
        | tar xz
    mv sample-project $1
    cd $1
    mv sample $1
    git init
}
