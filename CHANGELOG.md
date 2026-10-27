# Changelog

## 0.1.1 — adaptive palette beta (unreleased)

- Removed all hard-coded widget colors. Calendar, System, Network, and Storage now use Noctalia's live palette-role tokens.
- Widget backgrounds retain translucency via `surface/0.88`; labels, separators, borders, and metric accents respond to the active palette, including wallpaper-derived palettes when selected in Noctalia.
- There is no Original mode, theme selector, or new plugin setting. The widget automatically follows the shell palette.
- Kept `plugin_api = 37`, widget layout, calendar behavior, storage configuration, and Dotprofile untouched.
- Live light/dark and wallpaper palette testing is still pending; don't label as stable until tested on the desktop.

## 0.1.0 — initial beta (2026-10-27)

- Introduces four separately placeable desktop widgets: Calendar, System, Network, Storage.
- Calendar shows at most two upcoming events in a seven-day window plus an overflow counter; provider label is configurable without storing credentials.
- System and Network display Noctalia-provided statistics; Storage displays root and an optional additional absolute mount.
- Unnumbered panel headings, compact monospaced presentation and dark translucent cards.
- Initial local smoke test reported successful on the author's CachyOS desktop; broader compatibility and edge cases remain untested.
- No changes to Umbriel, Dotprofile, autostart, authentication, keybindings, or existing plugins.
