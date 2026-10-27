# Set up Homebrew PATH first (macOS)
set -x PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH

# User-local binaries (e.g. uv's installer places itself here on both macOS
# and Linux)
set -x PATH $HOME/.local/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

abbr -a v nvim
abbr -a ls eza
abbr -a wm workmux

workmux completions fish | source

starship init fish | source
zoxide init fish | source

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
