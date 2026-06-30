# Dotfiles

Personal config shared across laptops, organized as [GNU Stow](https://www.gnu.org/software/stow/)
packages. Secrets and machine-specific settings stay out of git.

## Install

```shell
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs Homebrew + the `Brewfile` deps, symlinks the packages with
`stow --no-folding`, and seeds your gitignored personal files from the `*.example` templates.
It is idempotent — safe to re-run after pulling updates.

Then fill in your details and reload:

```shell
$EDITOR ~/.gitconfig.local          # git name / email
$EDITOR ~/.config/zsh/secrets.zsh   # credentials / tokens
$EDITOR ~/.config/zsh/local.zsh     # machine-specific PATHs
gh auth login                        # preferred over a long-lived token
exec zsh
```

## Layout

Each top-level directory is a stow "package" that mirrors paths relative to `$HOME`:

| Package    | Installs |
|------------|----------|
| `zsh`      | `~/.zshenv` (sets `ZDOTDIR`) + `~/.config/zsh/*` |
| `git`      | `~/.gitconfig` + `~/.config/git/ignore` |
| `vim`      | `~/.vimrc` |
| `ghostty`  | `~/.config/ghostty/config` |
| `p10k`     | `~/.p10k.zsh` |
| `assets/`  | reference files only (iTerm color/keymap) — **not** stowed |

Install selectively per machine by editing `PACKAGES` in `bootstrap.sh`, or run stow directly:

```shell
stow --no-folding --target="$HOME" zsh git    # only what you want
```

`--no-folding` is important: it keeps `~/.config` a real directory and symlinks only the
tracked files, so other tools writing to `~/.config/<tool>/` never end up inside this repo.

## How config is split

**Zsh** uses `ZDOTDIR` (set in `~/.zshenv`) so the real entrypoint is `~/.config/zsh/.zshrc`.
That means the repo never owns `~/.zshrc` — it stays a plain, untracked file that tool
installers can append to freely. The entrypoint sources `~/.zshrc` last, so those appends
still work; migrate the keepers into `local.zsh`/`secrets.zsh` whenever you like.

Loaded in order:

- `plugins.zsh` — prompt + plugins (auto-cloned into `~/.local/share/zsh`)
- `base.zsh` — shared aliases (tracked)
- `keys.zsh` — keybindings + fzf-tab styling (tracked)
- `local.zsh` — machine-specific PATHs (**gitignored**)
- `secrets.zsh` — credentials / tokens (**gitignored**)
- `local.d/*.zsh` — drop-in files for any number of extra env/credential sets (**gitignored**)

**Git** commits a shared `~/.gitconfig` that `[include]`s `~/.gitconfig.local` (**gitignored**)
for per-machine identity and signing keys.

## Secrets

Nothing secret is committed. `secrets.zsh`, `local.zsh`, `local.d/`, and `~/.gitconfig.local`
are gitignored; only their `*.example` templates are tracked. Prefer `gh auth login` (keychain)
over storing a long-lived GitHub token.
