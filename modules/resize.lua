local hotkey = require 'hs.hotkey'
local window = require 'hs.window'

local resize = import('utils/resize')

local function module_init()
    local mash = config:get("slide.mash", { "cmd", "ctrl" })
    local keys = config:get("slide.keys", {
        UP = "up",
        DOWN = "down",
        LEFT = "left",
        RIGHT = "right",
    })

    for key, direction_string in pairs(keys) do
        local resize_fn = resize[direction_string]

        if resize_fn == nil then
            error("arrow: " .. direction_string .. " is not a valid direction")
        end

        hotkey.bind(mash, key, function()
            local win = window.focusedWindow()
            if win == nil then
                return
            end

            local dimensions = win:focusedWindow():frame()
            local newframe = resize_fn(dimensions)

            win:setFrameWithWorkarounds(newframe, 0)
        end)
    end
end

return {
    init = module_init
}
