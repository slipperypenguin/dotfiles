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

## Proposed Changes

### 1. Store the age private key in 1Password (replace passphrase flow)

**Why:** Eliminates the separate passphrase. On a new machine, if you're signed into 1Password, chezmoi bootstraps automatically — no memorized passphrase needed.

**How:**
1. Create a 1Password item (Secure Note or document) storing the age private key contents
   - Suggested: vault `Personal`, item name `chezmoi-age-key`, field `private-key`
   - The `op://` reference would be: `op://Personal/chezmoi-age-key/private-key`
2. Replace `run_onchange_before_decrypt-private-key.sh.tmpl`:

```bash
#!/bin/sh
# age key hash: {{ onepasswordRead "op://Personal/chezmoi-age-key/private-key" | sha256sum }}

if [ ! -f "${HOME}/.config/chezmoi/key.txt" ]; then
    mkdir -p "${HOME}/.config/chezmoi"
    cat > "${HOME}/.config/chezmoi/key.txt" << 'AGEKEY'
{{ onepasswordRead "op://Personal/chezmoi-age-key/private-key" }}
AGEKEY
    chmod 600 "${HOME}/.config/chezmoi/key.txt"
fi
```

3. `key.txt.age` can be removed from the repo (breaking change — keep it for one release cycle as fallback if desired)

**Bootstrap dependency:** `op` CLI must be installed and authenticated before `chezmoi init --apply`. This is already true in practice since Homebrew + 1Password are set up before dotfiles on a new machine.

**Tradeoff:** If 1Password is ever unavailable (offline, account locked), `chezmoi apply` still works because the decrypted `key.txt` is cached locally. Only the *first* apply on a new machine requires 1Password access.

---

### 2. Pull git identity from 1Password (replace promptStringOnce)

**Why:** Eliminates manual typing of email, name, and signing key at init. Values are always correct and consistent across machines.

**How:** Update `.chezmoi.toml.tmpl` to use `onepasswordRead` instead of `promptStringOnce` for identity fields:

```toml
{{- $machine_type := promptChoiceOnce . "machine_type" "Machine type" (list "personal" "work") -}}
encryption = "age"
[age]
    identity = "~/.config/chezmoi/key.txt"
    recipient = "age1l5jqj0vns7480h52qqam7fm044cypfh0gwt5c0g6fjncwhlzwyqqm7cu5q"
[edit]
    command = "nano"
[diff]
    pager = "delta"
[onepassword]
    prompt = true
[data]
    email = {{ onepasswordRead "op://Personal/chezmoi-identity/email" | quote }}
    git_name = {{ onepasswordRead "op://Personal/chezmoi-identity/name" | quote }}
    git_signing_key = {{ onepasswordRead "op://Personal/chezmoi-identity/signing-key" | quote }}
    machine_type = {{ $machine_type | quote }}
```

**1Password item setup:**
- Vault: `Personal`
- Item: `chezmoi-identity` (Secure Note or Login)
- Fields: `email`, `name`, `signing-key`

**Note:** `machine_type` stays as `promptChoiceOnce` — it's machine-specific, not an identity secret.

---

### 3. (Optional) Use 1Password for additional secrets in dotfiles

Once the integration is wired up, any future secret can use `onepasswordRead` in templates. Examples:

```bash
# In a future .env template or tool config:
export GITHUB_TOKEN='{{ onepasswordRead "op://Developer/github-pat/token" }}'
export CLOUDFLARE_API_TOKEN='{{ onepasswordRead "op://Personal/cloudflare/api-token" }}'
```

This is not a change to make now — just a pattern to follow going forward.

---

## Implementation Steps

| Step | Action | Risk |
|------|--------|------|
| 1 | Create `chezmoi-age-key` item in 1Password with age private key | None — 1Password only |
| 2 | Create `chezmoi-identity` item in 1Password with email/name/signing-key | None — 1Password only |
| 3 | Update `run_onchange_before_decrypt-private-key.sh.tmpl` to use `onepasswordRead` | Medium — changes bootstrap flow |
| 4 | Update `.chezmoi.toml.tmpl` to use `onepasswordRead` for identity, add `[onepassword]` section | Medium — changes init flow |
| 5 | Test on personal machine: `chezmoi init --apply` from scratch | Validates both changes |
| 6 | Test on work machine: same | Validates cross-machine |
| 7 | Remove `key.txt.age` from repo (optional, can defer) | Low — cleanup |
| 8 | Remove `promptStringOnce` variables that are no longer needed | Low — cleanup |

---

## Questions to Decide

1. **Age key storage format:** Secure Note field vs Document item?
   - *Secure Note field* is simpler (`onepasswordRead` with `op://` URL)
   - *Document* preserves exact file contents but uses `onepasswordDocument` (not available in Connect mode)
   - **Recommendation: Secure Note field** — simpler, works in all modes

2. **Keep `key.txt.age` as fallback?** Could keep it in the repo for one cycle so older machines that haven't signed into `op` yet can still bootstrap the old way. The script could try 1Password first, fall back to passphrase.

3. **Separate 1Password items or one combined item?**
   - One `chezmoi-identity` item with all fields is cleaner
   - Separate items per secret is more granular
   - **Recommendation: Two items** — `chezmoi-age-key` (the private key) and `chezmoi-identity` (git name/email/signing key)

4. **Work machine 1Password account:** Does the work machine use the same 1Password account, or a separate work account? If separate, we may need the `account` parameter on `onepasswordRead` calls, or use vault-scoped `op://` URLs.

---

## Rollback Plan

If anything breaks:
- `chezmoi init` still prompts for values if `onepasswordRead` fails (chezmoi errors visibly)
- The age key is cached at `~/.config/chezmoi/key.txt` after first successful run
- Reverting the two template files restores the original `promptStringOnce` + passphrase flow
