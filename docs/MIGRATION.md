# Original sidebar source migration

This release is a **new v5 preview** based on the reference screenshot. It does not contain or recover the original custom widget code stored on the user's CachyOS PC.

To preserve the *exact* original rather than merely approximate the look, first locate its source **on the live machine**, then make a read-only copy after careful review. No automatic scanning/upload is provided; automatic uploads can expose calendar data, credentials and private paths.

Suggested safe starting commands, run locally:

```sh
find ~/.config/noctalia ~/.local/share/noctalia -type f \
  \( -name '*.luau' -o -name '*.qml' -o -name 'plugin.toml' \) 2>/dev/null
```

If the sidebar came from a DMS extension, inspect its location separately rather than mixing in the experimental Island. Avoid dumping all files to chat or GitHub: review first, and share only the exact custom widget source with event details and credentials removed.

Compare original source and `sidebar-widgets/{calendar,system,network,storage}.luau` function-by-function, then port only what was author-written and compatible with Noctalia's public plugin API. Commit source imports to a separate branch for review.
