# Set up Homebrew PATH first (macOS)
set -x PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH

# User-local binaries (e.g. herdr's official self-updating installer places
# itself here on both macOS and Linux)
set -x PATH $HOME/.local/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here

    # herdr-shell-progress
    for d in (ls -td ~/.config/herdr/plugins/github/bayoudhi.shell-progress-*/ 2>/dev/null)
        if test -r $d/shell/init.fish
            source $d/shell/init.fish
            break
        end
    end
end

fish_vi_key_bindings

abbr -a v nvim
abbr -a ls eza

starship init fish | source
zoxide init fish | source

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
