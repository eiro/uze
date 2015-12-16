uze mir
uze devel/TAP :all

mir_is_loaded () {
    for expected ( mir/ed mir/dump ) {
        got="$( shush2 whence -wam $expected )"
        [[ ${got%: *} == $expected ]]
        ok "$expected is ready to use" || note "got $got"
    }
}

prove mir_is_loaded
