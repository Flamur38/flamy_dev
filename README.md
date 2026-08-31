# flamy_dev

Personal Linux dev-environment bootstrap: dotfiles, i3/zsh/neovim setup, and blue-team tooling — no GNU Stow, just plain `cp -a` syncing via `dev-env` and modular install scripts via `run`.

## Structure

```
.
├── dev-env          # Syncs configs/scripts/wallpapers/tools into $HOME (idempotent, supports --dry)
├── run              # Executes every executable script in runs/ (supports filtering + --dry)
├── env/             # Everything that gets synced into $HOME
│   ├── .config/     # i3, nvim, polybar, rofi, terminator
│   ├── .local/      # scripts (dev-commit, dev-env, fl4my-zeek, thermal.sh)
│   ├── Pictures/    # wallpapers
│   ├── tools/       # chainsaw (rules/mappings only — binary installed by runs/security_tools), go-brutus, mail-analysis scripts
│   └── .zshrc, .bashrc, .tmux.conf, .vimrc, .xinitrc, etc.
├── runs/            # One script per install target (zsh, neovim, i3, security_tools, docker, ...)
├── resources/
│   └── setup        # One-liner bootstrap for a brand-new machine (clones this repo + runs it)
└── README.md
```

## Quick start — fresh machine

```bash
curl -fsSL https://raw.githubusercontent.com/Flamur38/flamy_dev/main/resources/setup | bash
```

Or manually:

```bash
git clone https://github.com/Flamur38/flamy_dev ~/personal/dev
cd ~/personal/dev
chmod +x run
./run
```

## Cheatsheet

| Task | Command |
|---|---|
| Sync all dotfiles/configs/tools into `$HOME` | `./dev-env` |
| Preview what dev-env would change, no writes | `./dev-env --dry` |
| Run every install script in `runs/` | `./run` |
| Preview what run would execute, no writes | `./run --dry` |
| Run only one install script (exact filename) | `./run neovim` |
| Install just security/blue-team tools | `./run security_tools` |
| Install just zsh + Oh My Zsh + plugins | `./run zsh` |
| Set up i3 + polybar + rofi | `./run i3` |
| Clean up apt cache after installs | `./run cleanup` |
| Override where scripts think the repo lives | `DEV_ENV=/path/to/repo ./run` |
| Override XDG config target (rare) | `XDG_CONFIG_HOME=/path ./dev-env` |

## Notes

- `dev-env` is idempotent — safe to re-run any time after pulling changes.
- `run` executes scripts alphabetically by filename in `runs/`; there's no explicit ordering/dependency system, so if one script depends on another being run first, that's on you to sequence manually for now.
- `./run <filter>` matches the exact script filename (e.g. `./run terminal` runs only `runs/terminal`, not `runs/terminator`).
- Nothing here uses GNU Stow. Configs are copied (`cp -a`), not symlinked — editing a file in `~/.config` will not update the repo copy; edit the repo and re-run `./dev-env` instead.
- Chainsaw's binary is fetched fresh by `runs/security_tools` on install rather than vendored in git; only its rules/mappings/docs live under `env/tools/chainsaw/`.
- Third-party scripts under `env/tools/mail/` (`emldump.py`, `oledump.py`, `pdf-parser.py`, `pdfid.py`) are Didier Stevens' forensic analysis tools, not original work — see didierstevens.com / DidierStevens/DidierStevensSuite on GitHub for source and licensing.

## Open question

- `env/Pictures` (~82MB of wallpapers) is still committed to git, which bloats every clone. Worth moving to git-lfs, a separate assets repo, or a release asset that `dev-env` downloads on demand — hasn't been done yet since it changes how wallpapers get synced.
