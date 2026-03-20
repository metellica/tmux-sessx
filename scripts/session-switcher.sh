#!/usr/bin/env bash
# tmux session switcher
# keys: j/k or ↑/↓ navigate | enter switch | x delete | esc cancel

CURRENT="$(tmux display-message -p '#S')"

list_sessions() {
    tmux list-sessions -F '#{session_last_attached} #{session_name}' 2>/dev/null \
        | sort -rn \
        | awk '{print $2}' \
        | awk -v cur="$CURRENT" '
            $0 == cur { current = $0; next }
            { rest[++n] = $0 }
            END {
                if (current) print current
                for (i = 1; i <= n; i++) print rest[i]
            }'
}

pick_session() {
    list_sessions | fzf \
        --tmux 40%,40% \
        --layout reverse \
        --no-input \
        --border rounded \
        --border-label " Sessions " \
        --color "border:#89b4fa,label:#89b4fa,pointer:#f38ba8" \
        --pointer "▶" \
        --no-sort \
        --cycle \
        --bind "j:down,k:up" \
        --expect x \
        --header "enter=switch  x=delete  esc=cancel" \
        --header-first \
        --info hidden \
        --padding 0,1 \
        2>/dev/null
}

confirm_delete() {
    local session="$1"
    printf 'no\nyes' | fzf \
        --tmux 34%,20% \
        --layout reverse \
        --border rounded \
        --border-label " Delete '$session'? " \
        --color "border:#f38ba8,label:#f38ba8" \
        --no-input \
        --no-sort \
        --info hidden \
        2>/dev/null
}

while true; do
    output=$(pick_session)
    key=$(printf '%s' "$output" | head -1)
    selected=$(printf '%s' "$output" | sed -n '2p')

    [ -z "$selected" ] && break

    if [ "$key" = "x" ]; then
        [ "$(confirm_delete "$selected")" = "yes" ] && tmux kill-session -t "$selected" 2>/dev/null
        continue
    fi

    [ "$selected" != "$CURRENT" ] && tmux switch-client -t "$selected"
    break
done
