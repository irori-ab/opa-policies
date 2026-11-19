# Signed commits

Every commit pushed to this repo must be signed by whoever commits it. GitHub rejects a push that contains an unsigned commit, on any branch. These policies are the guardrails Terraform plans are checked against, so a signature is how we know who wrote a change.

Commits you make in the GitHub web UI are signed by GitHub for you, so edits, suggestions, merge commits and squash merges there need no setup. Avoid "Rebase and merge": it may be rejected under this rule. Everything you commit on your own machine needs the setup below, once per machine.

## Set up signing with an SSH key

This uses an SSH key, which is simpler than GPG. You can reuse the key you push with, or make a new one for signing.

1. Make a key if you don't have one:

   ```bash
   ssh-keygen -t ed25519 -C "you@irori.se"
   ```

2. Tell Git to sign every commit with it:

   ```bash
   git config --global gpg.format ssh
   git config --global user.signingkey ~/.ssh/id_ed25519.pub
   git config --global commit.gpgsign true
   ```

   If the key has a passphrase, load it into `ssh-agent` (`ssh-add`), or Git asks for it on every commit and tools that can't prompt fail.

3. Add the public key to GitHub as a **signing key**. A key added only as an authentication key does not count, even if it is the same key. In the web UI: Settings → SSH and GPG keys → New SSH key, with key type *Signing Key*. Or with `gh`:

   ```bash
   gh auth refresh -h github.com -s admin:ssh_signing_key
   gh ssh-key add ~/.ssh/id_ed25519.pub --type signing --title "laptop signing key"
   ```

4. Check that the email in your commits is a verified email on your GitHub account. GitHub only marks a commit *Verified* when it is.

   ```bash
   git config user.email
   ```

If you already sign with GPG, keep it: GPG-signed commits pass too.

## Use your YubiKey instead

The YubiKey you got from Irori can hold the signing key. The private key never leaves the YubiKey, so a stolen laptop can't sign commits as you. You touch the key once per commit.

1. Set a FIDO2 PIN on the YubiKey if it doesn't have one. The key in the next step is stored on the YubiKey, and that needs a PIN.

   ```bash
   ykman fido access change-pin
   ```

2. Make the key with the YubiKey plugged in. Touch it when it blinks.

   ```bash
   ssh-keygen -t ed25519-sk -O resident -C "you@irori.se" -f ~/.ssh/id_ed25519_sk
   ```

   If this fails because no FIDO provider is available, the `ssh-keygen` you ran can't talk to security keys. On macOS, install OpenSSH with `brew install openssh`, run the command again with Homebrew's `ssh-keygen`, and tell Git to sign with it:

   ```bash
   git config --global gpg.ssh.program "$(brew --prefix)/bin/ssh-keygen"
   ```

3. Follow steps 2 to 4 of the SSH setup above, with `~/.ssh/id_ed25519_sk.pub` as the key.

On a new laptop, `ssh-keygen -K` in `~/.ssh` gets the key files back from the YubiKey.

Things to know:

- Anything that commits for you, such as a script or an AI agent, waits until you touch the key.
- Re-signing a rejected branch takes one touch per commit.
- If you lose the YubiKey, you can't push until you add a new signing key on GitHub. A second YubiKey or a normal SSH key added as a backup avoids that.

## Check that it works

Push a branch and open the commit on GitHub. It should show **Verified**.

To check locally, Git needs a list of trusted SSH keys first:

```bash
echo "$(git config user.email) $(cat ~/.ssh/id_ed25519.pub)" >> ~/.ssh/allowed_signers
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
git log --show-signature -1
```

## If a push is rejected

GitHub names the commits it rejected. Sign them again and force-push your branch:

```bash
git fetch origin
git rebase --exec 'git commit --amend --no-edit -S' origin/main
git push --force-with-lease
```

Only do this on your own branch.

## Automation

- Dependabot commits, and commits made through the GitHub API with `GITHUB_TOKEN`, are signed by GitHub.
- A workflow that runs `git commit` and `git push` itself is not. Commit through the API instead, or give the job its own signing key.