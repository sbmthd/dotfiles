if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

abbr -a v nvim

starship init fish | source
zoxide init fish | source
carapace _carapace | source

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
