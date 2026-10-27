"""Static checks only. Live Noctalia/Luau UI behavior remains to be tested."""
import json
from pathlib import Path
import tomllib

root = Path(__file__).resolve().parents[1]
plugin = root / "sidebar-widgets"
manifest = tomllib.loads((plugin / "plugin.toml").read_text())
assert manifest["id"] == "gpkinze/sidebar-widgets"
assert manifest["plugin_api"] >= 37
entries = {row["id"]: row["entry"] for row in manifest["desktop_widget"]}
assert set(entries) == {"calendar", "system", "network", "storage"}
for title, path in entries.items():
    source = (plugin / path).read_text()
    assert source.startswith("--!nonstrict")
    assert "desktopWidget.render" in source
    assert "function update()" in source
    assert "noctalia.setUpdateInterval" in source
    assert f'"{title.upper()}"' in source
    assert not any(f'"{n:02d} / {title.upper()}"' in source for n in range(1, 5))
assert "calendarEvents()" in (plugin / "calendar.luau").read_text()
assert "more upcoming events" in (plugin / "calendar.luau").read_text()
assert "net.rxBytesPerSec" in (plugin / "network.luau").read_text()
assert "noctalia.diskStats" in (plugin / "storage.luau").read_text()
assert "noctalia.systemStats" in (plugin / "system.luau").read_text()
translations = json.loads((plugin / "translations/en.json").read_text())
for row in manifest["setting"]:
    assert row["label_key"] in translations
catalog = tomllib.loads((root / "catalog.toml").read_text())
for field in ("id", "name", "version", "plugin_api", "author", "license"):
    assert catalog["plugin"][0][field] == manifest[field]
for path in plugin.rglob("*"):
    if path.is_file():
        assert "@gmail.com" not in path.read_text()
print("Static package checks passed; no live Noctalia validation performed")
