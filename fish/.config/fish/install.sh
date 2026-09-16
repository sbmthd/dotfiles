#!/bin/bash

if ! fish -c 'type -q fisher' 2>/dev/null; then
    echo "Installing Fisher..."
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | fish -c 'source; and fisher install jorgebucaran/fisher'
fi

echo "Installing Fisher plugins..."
fish -c 'fisher update'

echo "Fish setup complete!"
