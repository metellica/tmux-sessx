# tmux-sessx

A minimal tmux session switcher using [fzf](https://github.com/junegunn/fzf). No external plugin dependencies.

## Features

- Popup session list with current session focused at top
- Navigate with `j`/`k` or `↑`/`↓`
- Delete sessions with confirmation
- Zero search input — pure keyboard navigation

## Requirements

- tmux ≥ 3.3
- fzf ≥ 0.54 (for `--tmux` and `--no-input`)

## Installation

### With [tpm](https://github.com/tmux-plugins/tpm)

Add to `~/.tmux.conf`:

```tmux
set -g @plugin 'yourusername/tmux-sessx'
```

Then press `prefix + I` to install.

### Manual

```bash
git clone https://github.com/yourusername/tmux-sessx ~/.tmux/plugins/tmux-sessx
```

Add to `~/.tmux.conf` after `run tpm`:

```tmux
run '~/.tmux/plugins/tmux-sessx/session-switcher.tmux'
```

## Usage

Press `prefix + o` to open the session switcher.

| Key        | Action                     |
|------------|----------------------------|
| `j` / `↓`  | Move down                  |
| `k` / `↑`  | Move up                    |
| `Enter`    | Switch to selected session |
| `x`        | Delete session (confirm)   |
| `Esc`      | Cancel                     |

## Configuration

Override the default bind key in `~/.tmux.conf`:

```tmux
set -g @sessx-bind 'o'
```
