# Changelog

## 0.1.1 — adaptive palette beta (2026-10-27)

- Replaced fixed widget colors with Noctalia palette-role tokens across Calendar, System, Network and Storage.
- Retained translucent surfaces via `surface/0.88`, with themed text, borders, dividers, accents and progress tracks.
- Widgets follow the active Noctalia theme, including wallpaper-derived palettes when that theme source is enabled.
- No appearance toggle, extra dependency or change to shell theme settings.
- Preserved widget layouts, existing settings and plugin API 37.
- Adaptive palette behavior smoke-tested on CachyOS with Umbriel and Noctalia; broader compatibility and contrast testing remain open.

## 0.1.0 — initial beta (2026-10-27)

- Added four independently placeable Noctalia desktop widgets: Calendar, System, Network and Storage.
- Calendar displays up to two upcoming events within seven days, followed by an overflow counter, with a configurable provider label.
- System and Network use Noctalia-provided metrics. Storage shows the root filesystem and an optional additional mount.
- Added compact monospaced layouts, translucent cards and unnumbered titles.
- Initial local smoke test completed on CachyOS; further hardware and calendar edge-case testing remains.
- No changes to Umbriel, Dotprofile, autostart, authentication, keybindings or other plugins.
