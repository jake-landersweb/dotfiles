# scripts

Shared executables, stowed into `~/.local/bin` (which is on `PATH`).

Add a script by dropping an executable file in `scripts/.local/bin/`:

```sh
chmod +x scripts/.local/bin/mytool
./bootstrap.sh            # or: stow --no-folding --target="$HOME" --restow scripts
```

## Available

| Command | Description |
| --- | --- |
| `wt <name> [branch]` | Create a git worktree at `~/worktrees/<repo>/<name>`, branching off `master`. Prints the path and copies it to the clipboard. |
