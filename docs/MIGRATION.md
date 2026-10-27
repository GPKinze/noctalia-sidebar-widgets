# Sidebar widget implementation notes

The current `sidebar-widgets/` directory contains a **Noctalia v5 Luau implementation** of four desktop widgets. It is not a byte-for-byte export of the earlier personalized sidebar configuration.

For anyone migrating an existing custom sidebar, review its source and settings before replacing it. Preserve a backup of the working plugin and check for local dependencies or version-specific APIs.

## Inspect an existing installation

These read-only commands can help locate source files:

```sh
find ~/.config/noctalia ~/.local/share/noctalia -type f \
  \( -name '*.luau' -o -name '*.qml' -o -name 'plugin.toml' \) 2>/dev/null
```

Keep implementation files separate from runtime state. Never commit real calendar events, credentials, access tokens, private settings or machine-specific paths.

If you adapt an earlier implementation, compare its behavior with the current Calendar, System, Network and Storage widgets, verify compatibility with the active Noctalia API, and submit the proposed changes through a separate branch or pull request.

This repository does not include a desktop configuration migration tool.
