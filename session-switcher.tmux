#!/usr/bin/env bash

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts/session-switcher.sh"
chmod +x "$SCRIPT"

BIND_KEY="$(tmux show-option -gqv "@sessx-bind")"
tmux bind-key "${BIND_KEY:-o}" run-shell "$SCRIPT"
