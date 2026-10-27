# Noctalia Sidebar Widgets

Four independent, compact desktop panels inspired by the author's Umbriel + Noctalia sidebar: **Calendar**, **System**, **Network**, and **Storage**. Each has an unnumbered title so panels can be arranged in any order.

> **v0.1.1 beta (adaptive palette).** This is a new Noctalia **v5 Luau** implementation inspired by the author's original sidebar screenshot, not a recovered copy of the original widgets. The author reported a successful initial live run on CachyOS, including configuring the second storage mount. Broader hardware, calendar edge-case, and version compatibility testing are still pending. Treat this as beta software.

## What it does

- Calendar: large date, weekday, month, next seven days; displays **two** event rows maximum plus `+N more upcoming events`, using Noctalia's already-synced calendar (no direct Google login or network calls).
- System: CPU, GPU, RAM from Noctalia's system monitor. GPU shows `N/A` when probing is unavailable.
- Network: receive/transmit rates from Noctalia's monitor, with suitable binary units.
- Storage: root filesystem plus an **optional** second user-configured mount, usage and available GiB.

Each card is a separate `[[desktop_widget]]` entry, so you can place, move or hide them independently. Dimensions and visual spacing are approximate and meant to be tuned against the live original.

## Appearance: always adaptive

**No appearance toggle or fixed-color theme.** All four cards use Noctalia palette-role tokens for text, accents, borders, progress tracks and a translucent background (`surface/0.88`). Noctalia resolves these tokens live against the active shell theme, so the cards follow light/dark changes and palette changes without extra scripts, settings, or a restart. If **Noctalia's theme source is set to wallpaper**, changing the wallpaper changes the palette and therefore the widget colors. If the active theme source is builtin, community, or custom, the widgets follow that palette instead; they do not extract colors from wallpapers on their own. The cards retain their original dimensions and overall hierarchy, but the accent color may no longer be teal.

This uses existing `plugin_api = 37` capabilities and intentionally avoids palette roles introduced in API 43. No changes to your shell's theme settings are performed by the plugin.

## Requirements

- Noctalia v5+ with **plugin API 37 or later** (calendarEvents API). These are *not* legacy QML/Quickshell or DankMaterialShell widgets.
- Noctalia calendar accounts synced if you want events displayed. Google authorization remains inside the Noctalia calendar service.
- Noctalia system monitor enabled for system/network/storage metrics; sensor availability is hardware-dependent.

## Sharing from a Git repository

After this repository is published, users can add it as a plugin source:

```sh
noctalia msg plugins source add sidebar-widgets git https://github.com/GPKinze/noctalia-sidebar-widgets.git
noctalia msg plugins enable gpkinze/sidebar-widgets
```

These commands work only once this GitHub repository is public. **If you have an older local copy under `~/.local/share/noctalia/plugins/sidebar-widgets/`, that copy takes precedence over the Git source.** Disable and archive the local copy before testing Git-based updates, and only after confirming the public copy is available.

## Safe test installation (does not overwrite your configuration)

1. Make sure you already have a desktop with Noctalia v5 and save any important settings.
2. Copy **only the `sidebar-widgets/` directory** into `~/.local/share/noctalia/plugins/sidebar-widgets/` (or use a development path source).
3. Enable the plugin:

   ```sh
   noctalia msg plugins enable gpkinze/sidebar-widgets
   ```

4. Open **Noctalia Settings → Desktop → Toggle Editor** and add the plugin desktop-widget entries `gpkinze/sidebar-widgets:calendar`, `gpkinze/sidebar-widgets:system`, `gpkinze/sidebar-widgets:network`, and `gpkinze/sidebar-widgets:storage`. Position them as a vertical stack. The editor can be toggled with:

   ```sh
   noctalia msg desktop-widgets-edit
   ```

   The exact picker wording may vary between Noctalia builds. Desktop widgets are managed through Noctalia's existing editor; this package does not edit `config.toml` or `settings.toml`.

5. Under **Settings → Plugins → Sidebar Widgets**, optionally set a storage mount (such as `/mnt/Storage`) and the calendar provider text (`Google` by default). Never enter a credential here.

## Uninstall

Remove the four desktop widget instances through the editor, disable the plugin with `noctalia msg plugins disable gpkinze/sidebar-widgets`, and remove its locally copied plugin directory if desired. This package creates no services, hooks, autostart, compositor keybindings, or persistent files.

## Compatibility and privacy

- Developed to the [official Noctalia plugin manifest](https://docs.noctalia.dev/noctalia/plugins/development/manifest/), [desktop UI API](https://docs.noctalia.dev/noctalia/plugins/development/declarative-ui/), and [runtime API](https://docs.noctalia.dev/noctalia/plugins/development/runtime-api/).
- Works through Noctalia's APIs: no `curl`, `nvidia-smi`, `/proc` parsing, or Google API keys. No external commands or network calls from this plugin.
- The label below events is a **configurable provider name**, not an email address; event titles are read in memory from the shell and are not logged or stored.
- All display data is local to the user session. This repository does not contain private calendar events, actual screenshots with event titles, tokens, machine paths, or exported Noctalia settings.
- `gruvbox-kanji` stays in the separate Dotprofile repository. The Island, DMS, and Cava are not part of this repo.

## Beta test coverage still needed

- [ ] Verify live palette repaint (switch built-in/community palettes, wallpaper-derived palettes, and light/dark mode) and text contrast.
- [ ] Test the four desktop entries on your live Noctalia version in a separate desktop layout.
- [ ] Compare geometry, opacity, typefaces and spacing to the original sidebar.
- [ ] Test calendar counts for 0/1/2/3+ events, all-day events, sync-not-ready and timezone transition.
- [ ] Test no GPU probe, monitor disabled, missing removable storage, reconnect/network idle.
- [ ] Confirm browser/UI label for the desktop picker, and update steps accordingly.
- [ ] Publish a screenshot with **sample events only** and run the privacy checklist.

See `docs/RELEASE.md` for publishing instructions, `docs/TESTING.md` for test expectations, and `docs/MIGRATION.md` for the original-source distinction.

Independent community work; not an official Noctalia or Umbriel project.
