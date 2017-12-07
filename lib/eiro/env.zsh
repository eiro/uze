# uze eiro/utils
# uze eiro/p6

# are following lines still relevant? uncomment if yes

# uze env
#
# # java:
# # * we need a -cp manager
# # * could nailgun be rewarding ?
#
# () { env/provides java || return
#     local cmd jar
#     for cmd jar (
#         plantuml plantuml.jar
#         ditaa    ditaa0_9.zip )
#             eval $cmd' () { java -jar '$HOME'/local/jar/'$jar' "$@" }' }
#
# () { env/home CLOJURESCRIPT_HOME &&
#     classpath+=( $1/clojure.jar(N) ) } ~/local/opt/clojurescript(N)
#
# # if present, loads the clojure profile (as provided by arch for example)
# : /etc/profile.d/clojure.sh('Ne:source $REPLY:')
#
# # create a ditaa command if the jar is presen
# () {
#     eval "ditaa () { java -jar $1"' "$@" }'
# } ~/local/opt/ditaa/ditaa0_9.jar(N)
