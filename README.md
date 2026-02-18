# dotfiles
![dotfiles](https://i.imgur.com/wKDfQxw.png)

Personal dotfiles for macOS, managed with [chezmoi](https://www.chezmoi.io).

## Quick Start

```bash
# Install chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply slipperypenguin
```

On first run, chezmoi will prompt for:

| Prompt | Description |
|--------|-------------|
| **Email address** | Used in `.gitconfig` |
| **Git name** | Used in `.gitconfig` |
| **Git signing-key** | GPG key ID for commit signing |
| **Machine type** | `personal` or `work` — controls machine-specific packages and config |

An age passphrase is also required to decrypt the private key used for encrypted files.

## What's Managed

| File | Description |
|------|-------------|
| `.bash_profile` | Shell config — Homebrew, Go, Rust, mise, direnv, k8s, aliases, prompt |
| `.gitconfig` | Git config — delta pager, LFS, signing, work-specific URL rewrites |
| `Brewfile` | Homebrew packages — shared base + machine-specific taps/brews/casks |

### Scripts

| Script | Trigger | Description |
|--------|---------|-------------|
| `run_onchange_before_decrypt-private-key` | age key missing or changed | Decrypts the age private key for chezmoi encryption |
| `run_onchange_before_install-packages-darwin` | Brewfile changes | Runs `brew bundle` with the rendered Brewfile |

## Machine Types

Templates use a `machine_type` data variable (`personal` or `work`) instead of hostname checks, making it easy to add new machines without changing templates:

- **personal** — personal dev machine packages (Flux, Talos, Docker, gaming, etc.)
- **work** — work-specific packages and config (VPN scripts, standup helper, URL rewrites)

## Repo Structure

```
.
├── .chezmoi.toml.tmpl                              # chezmoi config template (prompts + data)
├── .chezmoiignore                                  # files to ignore per machine type
├── .chezmoitemplates/
│   └── Brewfile.tmpl                               # Homebrew packages (shared + machine-specific)
├── key.txt.age                                     # encrypted age private key
├── private_dot_bash_profile.tmpl                   # ~/.bash_profile
├── private_dot_gitconfig.tmpl                      # ~/.gitconfig
├── run_onchange_before_decrypt-private-key.sh.tmpl # decrypt age key on change
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
* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [Dotfiles community](https://dotfiles.github.io)
