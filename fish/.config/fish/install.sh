#!/bin/bash

echo "Installing Fisher..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | fish -c 'source; and fisher install jorgebucaran/fisher'

echo "Installing Fisher plugins..."
fish -c 'fisher update'

echo "Fish setup complete!"
