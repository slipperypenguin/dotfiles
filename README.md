# dotfiles
![dotfiles](https://i.imgur.com/wKDfQxw.png)

Personal dotfiles for macOS, managed with [chezmoi](https://www.chezmoi.io).

## Prerequisites

1. **Homebrew** — [brew.sh](https://brew.sh)
2. **1Password + CLI** — install via `brew install 1password 1password-cli`
3. **Sign in to 1Password** — open the desktop app and authenticate, or run `op signin`

The following 1Password items must exist in the `CLI` vault before first run:

| Item | Type | Fields |
|------|------|--------|
| `chezmoi-age-key-doc` | Document | `key.txt` — age private key file |
| `chezmoi-identity` | Password | `email`, `git_name`, `git_signing_key` |

## Quick Start

```bash
# Ensure 1Password CLI is authenticated
op account get || eval "$(op signin)"

# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply slipperypenguin
```

On first run, chezmoi will prompt for:

| Prompt | Description |
|--------|-------------|
| **Machine type** | `personal` or `work` — controls machine-specific packages and config |
| **1Password account** | Your personal 1Password account (e.g. `my.1password.com`) |

Git identity (email, name, signing key) is pulled automatically from 1Password. The age encryption key is retrieved from 1Password with a fallback to passphrase decryption.

## What's Managed

| File | Description |
|------|-------------|
| `.bash_profile` | Shell config — Homebrew, Go, Rust, mise, direnv, k8s, aliases, prompt |
| `.gitconfig` | Git config — delta pager, LFS, signing, work-specific URL rewrites |
| `Brewfile` | Homebrew packages — shared base + machine-specific taps/brews/casks |

### Scripts

| Script | Trigger | Description |
|--------|---------|-------------|
| `run_onchange_before_decrypt-private-key` | age key missing or changed | Retrieves age key from 1Password (falls back to passphrase) |
| `run_onchange_before_install-packages-darwin` | Brewfile changes | Runs `brew bundle` with the rendered Brewfile |

## Machine Types

Templates use a `machine_type` data variable (`personal` or `work`) instead of hostname checks, making it easy to add new machines without changing templates:

- **personal** — personal dev machine packages (Flux, Talos, Docker, gaming, etc.)
- **work** — work-specific packages and config (VPN scripts, standup helper, URL rewrites)

## Repo Structure

```
.
├── .chezmoi.toml.tmpl                              # chezmoi config (1Password + data)
├── .chezmoiignore                                  # files to ignore per machine type
├── .chezmoitemplates/
│   └── Brewfile.tmpl                               # Homebrew packages (shared + machine-specific)
├── key.txt.age                                     # encrypted age private key (fallback)
├── private_dot_bash_profile.tmpl                   # ~/.bash_profile
├── private_dot_gitconfig.tmpl                      # ~/.gitconfig
├── run_onchange_before_decrypt-private-key.sh.tmpl # age key from 1Password / passphrase
└── run_onchange_before_install-packages-darwin.sh.tmpl  # brew bundle on Brewfile change
```

## Day-to-Day Usage

```bash
# Check for drift between source and target
dotdiff    # chezmoi diff
dotstat    # chezmoi status

# Pull latest and apply
dotsync    # chezmoi git pull --autostash --rebase && chezmoi apply -v

# Edit a managed file in the source state
chezmoi edit ~/.bash_profile

# Add a new file to chezmoi
chezmoi add ~/.config/some/config
```

## Additional Resources
* [chezmoi docs](https://www.chezmoi.io)
* [chezmoi + 1Password](https://www.chezmoi.io/user-guide/password-managers/1password/)
* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [Dotfiles community](https://dotfiles.github.io)
