--!nonstrict
-- Uses Noctalia system monitor snapshots; hardware probes may be unavailable.
local WIDTH, INNER = 258, 226
-- Keep every color tied to the active Noctalia palette.
local WHITE, MUTED = "on_surface", "on_surface_variant"
local TEAL, TRACK, BACK = "primary", "on_surface_variant/0.24", "surface/0.88"
local BORDER = "on_surface_variant/0.22"

local function label(text, color, size)
    return ui.label({ text = text, color = color or WHITE, fontSize = size or 11,
        fontFamily = "monospace", maxLines = 1 })
end

local function metric(name, value, fill)
    local pct = type(value) == "number" and math.max(0, math.min(100, value)) or nil
    return ui.column({ gap = 5 }, {
        ui.row({ width = INNER, justify = "space_between" }, {
            label(name), label(pct ~= nil and string.format("%.0f%%", pct) or "N/A", MUTED),
        }),
        ui.progress({ width = INNER, height = 7, progress = (pct or 0) / 100,
            fill = fill or TEAL, track = TRACK, radius = 3 }),
    })
end

function update()
    noctalia.setUpdateInterval(2000)
    local stats = noctalia.systemStats()
    local cpu = stats and stats.cpu and stats.cpu.usagePercent or nil
    local gpu = stats and stats.gpu and stats.gpu.usagePercent or nil
    local ram = stats and stats.ram and stats.ram.usagePercent or nil
    desktopWidget.render(ui.column({ width = WIDTH, gap = 11, padding = 16,
        fill = BACK, radius = 16, border = BORDER, borderWidth = 1 }, {
        label("SYSTEM", MUTED, 11),
        metric("CPU", cpu, TEAL),
        metric("GPU", gpu, "secondary"),
        metric("RAM", ram, "tertiary"),
    }))
end
