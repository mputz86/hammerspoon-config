local pathwatcher = require 'hs.pathwatcher'
local screenwatcher = require 'hs.screen.watcher'

local monitors = import('utils/monitors')
local monitors_current = monitors()

local function endswith(s, send)
    return #s >= #send and s:find(send, #s-#send+1, true) and true or false
end

local function did_lua_file_change(files)
    for _, file in ipairs(files) do
        if endswith(file, ".lua") then
            return true
        end
    end

    return false
end

local function on_files_changed(files)
    if did_lua_file_change(files) then
        hs.reload()
    end
end

local function on_screen_changed()
    local monitors_new = monitors()
    if (not (#monitors_new.configured_monitors == #monitors_current.configured_monitors)) then
        monitors_current = monitors_new
        hs.reload()
    end
end

return {
    init = function()
        pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", on_files_changed):start()
        screenwatcher.newWithActiveScreen(on_screen_changed):start()
    end
}
