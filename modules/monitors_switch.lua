local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local geometry = require 'hs.geometry'
local mouse = require 'hs.mouse'
local alert = require 'hs.alert'

local position = import('utils/position')
local monitors = import('utils/monitors')()

local function init_module()
    local mash = config:get("monitors_switch.mash", { "ctrl", "shift", "cmd" })
    local key = config:get("monitors_switch.key", "SPACE")

    hotkey.bind(mash, key, function()
        local win = window.focusedWindow()
        if win == nil then
            return
        end
        local frame = win:frame()
        local destinationMonitor = monitors.configured_monitors[1]
        local found = false
        for id, monitor in pairs(monitors.configured_monitors) do
            if  found then
                destinationMonitor = monitor
                break
            end
            --.. monitor.dimensions.x .. ", " .. monitor.dimensions.y)
            if frame.x >= monitor.dimensions.x and frame.x < monitor.dimensions.x + monitor.dimensions.w and frame.y >= monitor.dimensions.y and frame.y < monitor.dimensions.y + monitor.dimensions.h then
                found = true
            end
        end
        if found then
            win:setFrame(destinationMonitor.dimensions:relative_window_position(win))
        end
    end)
end

return {
    init = init_module
}
