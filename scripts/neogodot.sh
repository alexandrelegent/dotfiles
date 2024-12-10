#!/usr/bin/env zsh

# Setup in Godot
# Settings > Text Editor > External
# Exec Flags: "{project}" "{file}" "{line}" "{col}"

nvim="/etc/profiles/per-user/alegent/bin/nvim"
neovide="/etc/profiles/per-user/alegent/bin/neovide"
server_path="$HOME/.cache/nvim/godot-server.pipe"
server_startup_delay=1

project="$1"
line="$3"
col="$4"
filename=$(printf %q "$2")

echo "$project" "$filename" "$line" "$col" > /tmp/godot.txt

if ! [ -e "$server_path" ]; then
    pushd "$project" || exit
    $neovide -- --listen "$server_path" 2&>/dev/null
    sleep $server_startup_delay
fi

$nvim --headless --server "$server_path" --remote-send "<C-\><C-n>:n $filename<CR>:call cursor($line, $col)<CR>"
