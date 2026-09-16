#!/bin/bash
set -e

# Stows every package in this repo, then runs each package's install.sh (if
# it has one). Safe to re-run: a package whose target already has a real,
# non-symlinked file where a symlink should go is skipped with a clear
# message instead of being clobbered - move the conflicting file aside
# yourself (see herdr's own README on this, it hit exactly that case) and
# re-run.

cd "$(dirname "$0")"

if ! command -v stow >/dev/null 2>&1; then
    echo "GNU stow is required (e.g. 'brew install stow' or 'sudo pacman -S stow')." >&2
    exit 1
fi

packages=(fish ghostty herdr nvim tmux)

echo "== Stowing packages =="
for pkg in "${packages[@]}"; do
    # stow -n always prints a "simulation mode" notice to stderr even when
    # there's nothing wrong - the exit code, not stderr content, is what
    # actually distinguishes a real conflict from a clean dry run.
    if ! dry_run_err=$(stow --no-folding -n "$pkg" 2>&1 >/dev/null); then
        echo "  SKIP $pkg - conflicts, resolve manually then re-run:"
        echo "$dry_run_err" | sed 's/^/    /'
        continue
    fi
    stow --no-folding "$pkg"
    echo "  OK $pkg"
done

echo
echo "== Running package install scripts =="
for pkg in "${packages[@]}"; do
    script="$pkg/.config/$pkg/install.sh"
    if [ -f "$script" ]; then
        echo "  running $script"
        bash "$script"
    fi
done

echo
echo "Bootstrap complete."
