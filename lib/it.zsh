it/say  () { "$@" && print yes || print no }
it/said () { sed -n 's/^'$1' //p' }

