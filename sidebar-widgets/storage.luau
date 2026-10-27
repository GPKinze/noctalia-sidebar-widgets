--!nonstrict
-- Read-only usage for / and an optional user-configured mount.
local WIDTH, INNER = 258, 226
local WHITE, MUTED = "#dee0dc", "#b1bab7"
local TEAL, TRACK, BACK = "#48d6c4", "#414643", "#101514e0"

local function text(value, color, size)
    return ui.label({ text = value, color = color or WHITE, fontSize = size or 11,
        fontFamily = "monospace", maxLines = 1 })
end

local function diskRow(path, name)
    local stats = noctalia.diskStats(path)
    local percent = stats and stats.usagePercent or nil
    local pct = type(percent) == "number" and math.max(0, math.min(100, percent)) or nil
    local available = (stats and type(stats.availableBytes) == "number")
        and string.format("Available: %.1f GiB", stats.availableBytes / (1024 ^ 3))
        or "Unavailable or waiting for sample"
    return ui.column({ gap = 6 }, {
        ui.row({ width = INNER, justify = "space_between" }, {
            text(name, WHITE), text(pct and string.format("%.0f%%", pct) or "N/A", MUTED),
        }),
        ui.progress({ progress = (pct or 0) / 100, width = INNER, height = 7,
            fill = TEAL, track = TRACK, radius = 3 }),
        text(available, MUTED, 10),
    })
end

function update()
    noctalia.setUpdateInterval(10000)
    local mount = tostring(noctalia.getConfig("storage_path") or "")
    -- Avoid probing arbitrary relative paths; optional extra path is explicitly user-selected.
    if mount ~= "" and mount:sub(1, 1) ~= "/" then mount = "" end
    local rows = { text("STORAGE", MUTED, 11), diskRow("/", "System /") }
    if mount ~= "" and mount ~= "/" then
        table.insert(rows, diskRow(mount, mount))
    else
        table.insert(rows, text("Set additional mount in plugin settings", MUTED, 10))
    end
    desktopWidget.render(ui.column({ width = WIDTH, gap = 13, padding = 16,
        fill = BACK, radius = 16, border = "#4c5d554a", borderWidth = 1 }, rows))
end
