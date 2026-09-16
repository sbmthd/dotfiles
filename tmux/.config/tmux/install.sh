#!/bin/bash

# Plugins are gitignored (TPM clones each as its own git repo), so a fresh
# machine needs TPM bootstrapped before `prefix + I` will work.
#
# Note the path: tmux.conf loads TPM from ~/.tmux/plugins/tpm, not the XDG
# location, so that is where it has to go.
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
    echo "Updating TPM..."
    git -C "$TPM_DIR" pull --ff-only
else
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo "Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins"

echo "tmux setup complete!"
