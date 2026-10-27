# Test status and manual validation

**Static package validation:** `python tests/test_package.py` checks the manifest, paths, translations, catalog, and basic source expectations. It is not a Luau compiler or an in-shell test.

**Live testing:** The author confirmed the plugin appeared in `noctalia msg plugins list`, was enabled, and the Storage widget worked after configuring its additional mount on CachyOS (2026-10-27). This is an informal live smoke test, not an exhaustive compatibility certificate. Exact Noctalia build number was not recorded.

## Before calling this stable

1. Calendar: empty, unsynced, 1, 2 and 3+ events; all-day events, multiple accounts, time zone changes, next-day rollover.
2. System: sensor unavailable, disabled monitor, missing GPU, CPU/RAM load spikes.
3. Network: offline/no interface, bandwidth bursts, and reconnect.
4. Storage: missing/unmounted extra mount, root-only behavior, zero-sized/invalid stats.
5. Settings, layouts and migrations: plugin disabled/enabled, different monitor resolutions, widget move/resize, Noctalia upgrades and source updates.
6. Review screenshots carefully: remove real calendar event contents and any private mount/device information before publishing.

User-reported live behavior may differ from source static checks. Please file bugs with Noctalia version, widget name, reproduction steps, and sanitized logs; never post credentials.
