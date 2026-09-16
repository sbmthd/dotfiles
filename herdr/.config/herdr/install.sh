#!/bin/bash
set -e

# GitHub plugins live outside version control (see .gitignore), so a fresh
# machine needs them reinstalled from plugins.txt, the same way tmux's
# install.sh replays TPM plugins from tmux.conf's @plugin lines.

if ! command -v herdr >/dev/null 2>&1; then
    echo "Installing herdr..."
    curl -fsSL https://herdr.dev/install.sh | sh
fi

if ! command -v cargo >/dev/null 2>&1; then
    echo "Installing Rust (required to build herdr plugins)..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"
fi

PLUGINS_FILE="$(dirname "$0")/plugins.txt"

while IFS= read -r plugin; do
    plugin="${plugin%%#*}"
    plugin="$(echo "$plugin" | xargs)"
    [ -z "$plugin" ] && continue

    echo "Installing herdr plugin $plugin..."
    herdr plugin install "$plugin" --yes
done < "$PLUGINS_FILE"

echo "herdr setup complete!"
