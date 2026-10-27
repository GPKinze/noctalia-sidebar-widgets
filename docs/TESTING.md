# Testing and compatibility

## Automated checks

Run `python tests/test_package.py` from the repository root. The script checks the plugin manifest, file paths, translations, catalog consistency and source invariants. It is a **static package check**, not a Luau compiler or a live shell integration test.

## Local smoke test (2026-10-27)

The plugin was recognized and enabled in Noctalia on CachyOS with Umbriel. The optional second storage mount was configured successfully. The v0.1.1 adaptive-color update was subsequently installed locally and reported to work with the active Noctalia palette.

These observations confirm a successful initial setup, not broad compatibility. The exact Noctalia build number and a full matrix of theme, hardware and calendar edge cases were not recorded.

## Recommended manual tests

1. **Calendar:** unsynced, zero, one, two and three or more events; all-day events; multiple accounts; time zone changes and midnight rollover.
2. **System:** unavailable sensors, missing GPU, disabled monitor and fluctuating usage.
3. **Network:** offline state, reconnect, idle traffic and sustained transfer.
4. **Storage:** root-only configuration, optional mount present/missing, invalid or unmounted paths and low free space.
5. **Adaptive theme:** contrasting built-in/community palettes, wallpaper-derived palettes, light and dark modes, text contrast and repaint without restarting.
6. **Lifecycle:** widget add/remove, plugin disable/enable, clean Git-source installation, multiple screen sizes and Noctalia upgrades.

Avoid including real event details, credentials, email addresses or other private data in bug reports and screenshots. When reporting an issue, include a sanitized screenshot, the Noctalia version and clear reproduction steps.
