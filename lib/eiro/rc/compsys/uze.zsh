# completion

_expand_command() { _expand_word || _autocd }
compdef _expand_command -command-
zstyle :completion:expand-word:expand:-command-:: tag-order all-expansions
zstyle :completion:expand-word:expand:-command-:: suffix false
