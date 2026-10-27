# Noctalia Sidebar Widgets

A collection of four compact, independently placeable desktop widgets for **Noctalia v5**: **Calendar**, **System**, **Network**, and **Storage**. Built for a minimal sidebar layout, but the widgets can be positioned separately.

**Current release:** [v0.1.1-beta](https://github.com/GPKinze/noctalia-sidebar-widgets/releases/tag/v0.1.1-beta). Smoke-tested on CachyOS with Umbriel and Noctalia. Other hardware and Noctalia builds have not been fully tested.

## Screenshots

Three desktop examples showing the same four widgets with different Noctalia palettes. **Calendar entries in these screenshots are sample data**; private event details have been replaced.

| Warm · Sunset | Cool · Mountains | Green · City |
| :---: | :---: | :---: |
| [![Sunset palette preview](screenshots/adaptive-sunset-preview.webp)](screenshots/adaptive-sunset.webp) | [![Mountain palette preview](screenshots/adaptive-mountains-preview.webp)](screenshots/adaptive-mountains.webp) | [![Green city palette preview](screenshots/adaptive-city-preview.webp)](screenshots/adaptive-city.webp) |

Select a preview to view the full desktop screenshot. Wallpapers are shown for illustration and are not distributed separately by this plugin.

## Widgets

| Widget | Displays |
| --- | --- |
| **Calendar** | Date, weekday, month and up to two events in the next seven days, with a counter for additional events |
| **System** | CPU, GPU and RAM usage; unavailable GPU metrics show `N/A` |
| **Network** | Download and upload speeds |
| **Storage** | Usage and available capacity for the root filesystem and an optional second mount |

Each panel has its own `[[desktop_widget]]` entry and an unnumbered title.

## Adaptive colors

All four widgets automatically follow **Noctalia's active color palette**. Colors update with the shell's light/dark mode and theme. When Noctalia is set to use wallpaper-derived colors, they also follow wallpaper palette changes.

The translucent background uses `surface/0.88`. Text, borders, dividers, progress tracks and accents use palette-role tokens. There is no separate theme mode or fixed-color fallback, and this plugin does not change Noctalia's own theme settings.

## Requirements

- Noctalia v5 with plugin API **37 or later**.
- Noctalia calendar integration configured and synced if you want upcoming events.
- Noctalia system monitoring available for system, network and disk metrics. Some sensors may be unavailable on certain hardware.

This is a Noctalia **Luau** plugin, not a legacy QML widget.

## Install from GitHub

Add this public repository as a Git plugin source:

```sh
noctalia msg plugins source add sidebar-widgets git https://github.com/GPKinze/noctalia-sidebar-widgets.git
noctalia msg plugins enable gpkinze/sidebar-widgets
```

**Note:** A local copy at `~/.local/share/noctalia/plugins/sidebar-widgets/` takes precedence over a Git-sourced copy of the same plugin. If you previously installed it manually, back up the local directory before changing sources. Installation from the public Git source still needs clean-environment testing.

### Add the widgets

1. Open **Noctalia Settings → Desktop → Toggle Editor**, or run:

   ```sh
   noctalia msg desktop-widgets-edit
   ```

2. Add any of these plugin widgets:
   - `gpkinze/sidebar-widgets:calendar`
   - `gpkinze/sidebar-widgets:system`
   - `gpkinze/sidebar-widgets:network`
   - `gpkinze/sidebar-widgets:storage`
3. Position each widget wherever you prefer.

Exact names in the picker may vary by Noctalia version.

### Settings

Under **Noctalia Settings → Plugins → Sidebar Widgets**, you can change:

- **Calendar provider label:** defaults to `Google`. This is display text, not a login.
- **Additional storage mount:** optional absolute mount path, such as `/mnt/Storage`.

The calendar uses Noctalia's existing synced events; no Google credentials or API tokens are required by this plugin.

## Uninstall

Remove the desktop widget instances using Noctalia's editor and disable the plugin:

```sh
noctalia msg plugins disable gpkinze/sidebar-widgets
```

If you installed it manually, you may then remove your local plugin copy. The plugin does not configure autostart, compositor keybindings, authentication or user hooks.

## Status and compatibility

This is **beta software**. The local CachyOS setup has been smoke-tested, including the optional storage mount and adaptive palette behavior. Calendar edge cases, missing hardware sensors, clean Git-source installation and other Noctalia versions remain to be verified. See [Testing](docs/TESTING.md).

The implementation uses Noctalia's [manifest](https://docs.noctalia.dev/noctalia/plugins/development/manifest/), [declarative UI](https://docs.noctalia.dev/noctalia/plugins/development/declarative-ui/) and [runtime](https://docs.noctalia.dev/noctalia/plugins/development/runtime-api/) APIs. It does not spawn monitoring tools or make its own network requests.

For contributors: see the [changelog](CHANGELOG.md), [release checklist](docs/RELEASE.md) and [migration notes](docs/MIGRATION.md). Please avoid including real event details, credentials or private paths in issues and screenshots.

This is an independent community project and is not officially affiliated with Noctalia or Umbriel. Licensed under [MIT](LICENSE).
