# 1Password Integration Plan

## Current State

Today the repo uses **three mechanisms** for secrets/identity:

| Secret | How it's stored | Problem |
|--------|----------------|---------|
| age private key | `key.txt.age` (passphrase-encrypted in repo) | Must remember a separate passphrase; prompted on first `chezmoi init` |
| email, git_name, git_signing_key | `promptStringOnce` (typed manually at init) | Must remember/look up values; easy to mistype |
| machine_type | `promptChoiceOnce` (selected at init) | Fine as-is — not a secret, just a toggle |

1Password is already installed on all machines (`brew "1password-cli"` in Brewfile) and bash completion is sourced in `.bash_profile`, but **nothing in chezmoi actually uses it yet**.

---

## Decisions

1. **Age key storage format:** Document type (`onepasswordRead` with `op://` URL)
2. **Keep `key.txt.age` as fallback:** Yes — the decrypt script tries 1Password first, falls back to passphrase
3. **1Password items:** Two items in `CLI` vault — `chezmoi-age-key-doc` (Document) and `chezmoi-identity` (Password)
4. **Multi-account:** Personal and work are separate 1Password accounts. All chezmoi secrets live in the personal 1Password account's `CLI` vault. A `onepassword_account` data variable is prompted at init so `onepasswordRead` always targets the correct account regardless of which machine you're on.

---

## Changes

### 1. Store the age private key in 1Password (replace passphrase flow)

**Why:** Eliminates the separate passphrase. On a new machine, if you're signed into 1Password, chezmoi bootstraps automatically.

**How:**
1. Create a 1Password Document in vault `CLI`, item `chezmoi-age-key-doc`, file `key.txt`
   - `op://CLI/chezmoi-age-key-doc/key.txt`
2. Update `run_onchange_before_decrypt-private-key.sh.tmpl` to try 1Password first, fall back to passphrase
3. Keep `key.txt.age` in repo as fallback

**Bootstrap dependency:** `op` CLI must be installed and authenticated before `chezmoi init --apply`. The script prompts `op signin` if not authenticated.

### 2. Pull git identity from 1Password (replace promptStringOnce)

**Why:** Eliminates manual typing of email, name, and signing key at init.

**How:**
1. Create a 1Password Password item in vault `CLI`, item `chezmoi-identity`
   - Fields: `email`, `git_name`, `git_signing_key`
2. Update `.chezmoi.toml.tmpl` to use `onepasswordRead` with account parameter
3. Add `[onepassword]` config section with `prompt = true`
4. Add `onepassword_account` as a `promptStringOnce` so the user enters their personal 1Password account identifier once

**Note:** `machine_type` stays as `promptChoiceOnce` — it's machine-specific, not a secret.

### 3. Update README

Add prerequisites section documenting the 1Password bootstrap requirement.

---

## 1Password Items to Create (manual step)

### Item 1: `chezmoi-age-key-doc`
- **Vault:** CLI
- **Type:** Document
- **Fields:**
  - `key.txt` — age private key file (contents of `~/.config/chezmoi/key.txt`)

### Item 2: `chezmoi-identity`
- **Vault:** CLI
- **Type:** Password
- **Fields:**
  - `email` — git email address
  - `git_name` — git display name
  - `git_signing_key` — GPG signing key ID

---

## Rollback Plan

If anything breaks:
- The decrypt script falls back to `key.txt.age` passphrase if 1Password is unavailable
- The age key is cached at `~/.config/chezmoi/key.txt` after first successful run
- Reverting the two template files restores the original `promptStringOnce` + passphrase flow
