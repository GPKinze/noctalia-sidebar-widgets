--!nonstrict
-- Compact sidebar calendar. Reads Noctalia's synced events; no API credentials.

local WIDTH = 258
local INNER = 226
local WHITE = "#dee0dc"
local MUTED = "#b1bab7"
local TEAL = "#48d6c4"
local BACK = "#101514e0"
local WEEK_MS = 7 * 24 * 60 * 60 * 1000

local function label(text, size, color, weight)
    return ui.label({ text = text, fontSize = size or 12,
        color = color or WHITE, fontWeight = weight or "normal",
        fontFamily = "monospace", maxLines = 1 })
end

local function header()
    return label("CALENDAR", 11, MUTED, "bold")
end

local function eventLabel(event, now)
    if event.startMs <= now and event.endMs > now then return "Now" end
    local when = os.date("%Y-%m-%d", math.floor(event.startMs / 1000))
    local today = os.date("%Y-%m-%d")
    local tomorrow = os.date("%Y-%m-%d", os.time() + 24 * 60 * 60)
    if when == today then return "Today" end
    if when == tomorrow then return "Tomorrow" end
    return os.date("%a %d %b", math.floor(event.startMs / 1000))
end

local function eventRow(event, now, provider)
    local clock = event.allDay and "ALL DAY" or os.date("%I:%M %p", math.floor(event.startMs / 1000))
    clock = clock:gsub("^0", "")
    local title = tostring(event.title or "Untitled event")
    if #title > 19 then title = title:sub(1, 16) .. "..." end
    return ui.row({ gap = 8, width = INNER }, {
        ui.box({ fill = TEAL, width = 3, height = 34, radius = 2 }),
        ui.column({ gap = 2, flexGrow = 1 }, {
            ui.row({ justify = "space_between", width = INNER - 14 }, {
                label(title, 12, WHITE), label(clock, 10, MUTED),
            }),
            label(eventLabel(event, now) .. " · " .. provider, 10, MUTED),
        }),
    })
end

local function visibleEvents(events, now)
    local eligible = {}
    for _, event in ipairs(events) do
        if type(event.startMs) == "number" and type(event.endMs) == "number"
            and event.endMs > now and event.startMs < now + WEEK_MS then
            table.insert(eligible, event)
        end
    end
    table.sort(eligible, function(a, b)
        if a.startMs == b.startMs then
            return tostring(a.title or "") < tostring(b.title or "")
        end
        return a.startMs < b.startMs
    end)
    return eligible
end

function update()
    noctalia.setUpdateInterval(30000)
    local now = noctalia.nowMs()
    local provider = tostring(noctalia.getConfig("calendar_label") or "Google")
    -- Deliberately do not show emails even if a user config contains one.
    if provider:find("@", 1, true) then provider = "Calendar" end
    local items = noctalia.calendarEvents()
    local date = os.date("%d")
    local children = {
        header(),
        ui.row({ gap = 8, align = "center", width = INNER }, {
            label(tostring(tonumber(date)), 48, WHITE, "bold"),
            ui.column({ gap = 2 }, {
                label(os.date("%A"), 12, WHITE),
                label(os.date("%B %Y"), 11, MUTED),
            }),
        }),
        ui.separator({ color = "#39413e", thickness = 1, spacing = 4 }),
        ui.row({ justify = "space_between", width = INNER }, {
            label("UPCOMING EVENTS", 10, MUTED, "bold"),
            label("NEXT 7 DAYS", 10, MUTED),
        }),
    }
    if items == nil then
        table.insert(children, label("Waiting for calendar sync", 11, MUTED))
    else
        local upcoming = visibleEvents(items, now)
        if #upcoming == 0 then
            table.insert(children, label("No upcoming events", 11, MUTED))
        else
            for i = 1, math.min(2, #upcoming) do
                table.insert(children, eventRow(upcoming[i], now, provider))
            end
            if #upcoming > 2 then
                table.insert(children, label("+" .. (#upcoming - 2) .. " more upcoming events", 10, MUTED))
            end
        end
    end
    desktopWidget.render(ui.column({ width = WIDTH, gap = 12, padding = 16,
        fill = BACK, radius = 16, border = "#4c5d554a", borderWidth = 1 }, children))
end
