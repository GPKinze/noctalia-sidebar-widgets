# Publishing v0.1.0 beta to GitHub

This folder is the repository source; **the repository is not created by downloading this archive**.

The GitHub username verified in this project is `GPKinze`. Use a terminal on CachyOS, with Git and the authenticated `gh` GitHub CLI installed. Keep the repository name `noctalia-sidebar-widgets`.

Review staged content and ensure no personal calendar data, credentials, token files or screenshots appear in the commit. The MIT license is included; confirm the chosen license is acceptable.

```fish
cd ~/Downloads
mkdir -p sidebar-release
unzip noctalia-sidebar-widgets-v0.1.0-beta.zip -d sidebar-release
cd sidebar-release/noctalia-sidebar-widgets
python tests/test_package.py

git init -b main
git add .
git diff --cached --check
git diff --cached --stat
git status --short
git commit -m "feat: initial Noctalia sidebar widgets beta"
gh auth status
gh repo create GPKinze/noctalia-sidebar-widgets --public --source=. --remote=origin --push
```

**If the repo name already exists, do not run `gh repo create` again.** Instead inspect the existing repository and choose an appropriate non-destructive push path.

After the GitHub repo exists, consider a GitHub prerelease tag `v0.1.0-beta` (manifest version stays `0.1.0` because the Noctalia manifest requires exactly three numeric parts).

## Important for local source testing

Noctalia prioritizes `~/.local/share/noctalia/plugins/sidebar-widgets/` over a Git source for the same plugin ID. Installing the Git source while the local drop-in still exists will not test the public copy. Preserve the working local files until the public repository has been verified, then move the old local plugin out of the plugin search path if you want to test updates from GitHub.

## Future community plugin store submission

Publishing your own GitHub repo is separate from contributing to `noctalia-dev/community-plugins`. Community store submission has additional README, thumbnail and CI requirements and is not part of the beta publication.
