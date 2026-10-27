--!nonstrict
-- Network rates come from Noctalia systemStats().net (bytes per second).
local WIDTH, INNER = 258, 226
-- Use live Noctalia palette roles instead of fixed hex colors.
local WHITE, MUTED = "on_surface", "on_surface_variant"
local TEAL, BACK = "primary", "surface/0.88"
local BORDER = "on_surface_variant/0.22"

local function text(value, color, size)
    return ui.label({ text = value, color = color or WHITE, fontSize = size or 11,
        fontFamily = "monospace", maxLines = 1 })
end

local function rate(bytes)
    if type(bytes) ~= "number" then return "N/A" end
    local units = { "B/s", "KiB/s", "MiB/s", "GiB/s" }
    local n, i = math.max(0, bytes), 1
    while n >= 1024 and i < #units do n, i = n / 1024, i + 1 end
    return string.format("%.1f %s", n, units[i])
end

function update()
    noctalia.setUpdateInterval(1000)
    local stats = noctalia.systemStats()
    local net = stats and stats.net or nil
    desktopWidget.render(ui.column({ width = WIDTH, gap = 12, padding = 16,
        fill = BACK, radius = 16, border = BORDER, borderWidth = 1 }, {
        text("NETWORK", MUTED, 11),
        ui.row({ width = INNER, justify = "space_between" }, {
            text("↓ Download", WHITE), text(rate(net and net.rxBytesPerSec), MUTED),
        }),
        ui.row({ width = INNER, justify = "space_between" }, {
            text("↑ Upload", TEAL), text(rate(net and net.txBytesPerSec), MUTED),
        }),
    }))
end
