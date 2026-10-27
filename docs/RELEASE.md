# Release and maintenance checklist

Repository: [GPKinze/noctalia-sidebar-widgets](https://github.com/GPKinze/noctalia-sidebar-widgets)

**Latest published prerelease:** [v0.1.1-beta](https://github.com/GPKinze/noctalia-sidebar-widgets/releases/tag/v0.1.1-beta).

The repository is already public. Do not run `git init`, `gh repo create`, or the original ZIP-based bootstrap instructions when preparing an update.

## Before a change

1. Start from the latest `main` branch and create a feature branch.
2. Limit the diff to the component or documentation being changed.
3. Inspect all staged files for credentials, tokens, real calendar events, personal addresses and local paths.
4. Keep plugin metadata in `sidebar-widgets/plugin.toml` and `catalog.toml` consistent whenever the plugin version changes.
5. Confirm compatibility with the documented Noctalia plugin API.

## Validate

Run the static package checks from the repository root:

```sh
python tests/test_package.py
git diff --check
```

Static tests check packaging and source invariants; they do **not** verify runtime rendering.

For code changes, also test the four widgets in a live Noctalia session: event counts, hardware metrics, optional storage mount, wallpaper-derived colors, light/dark contrast and plugin enable/disable behavior. See [TESTING.md](TESTING.md).

## Publish an update

1. Open a pull request with a clear change summary and testing notes.
2. Review and merge it into `main`.
3. Confirm `plugin.toml`, `catalog.toml`, README and changelog reflect the intended version.
4. Create a GitHub prerelease or stable release tag **only after** the changes are merged and tested. Use a three-part numeric version in `plugin.toml` (for example `0.1.2`), with prerelease notation in the GitHub tag (for example `v0.1.2-beta`).
5. Check the public installation instructions and release notes.

Do not create duplicate release tags for versions that already exist.

## Git-source versus local copies

Noctalia prioritizes a local directory at `~/.local/share/noctalia/plugins/sidebar-widgets/` over the Git plugin source with the same ID. Back up a working local installation before testing updates from GitHub, and confirm the Git source is available before removing or moving the local one.

## Community store

Publishing this repository is separate from submitting to [Noctalia community plugins](https://github.com/noctalia-dev/community-plugins). Review current submission and asset requirements before proposing inclusion.
