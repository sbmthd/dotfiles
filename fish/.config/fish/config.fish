if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias v nvim

starship init fish | source
zoxide init fish | source
carapace _carapace | source

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
