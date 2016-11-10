local alert = require 'hs.alert'
local window = require 'hs.window'
local grid = require 'hs.grid'

local monitors = import('utils/monitors')

local resize = {}
local horizontalSplits = config:get("resize.horizontal_splits", 6)
local verticalSplits = config:get("resize.vertical_splits", 4)

-- workaround due to incorrect movement of windows to borders of monitor
local allowedPixelOffset = 20
local pixelOffsetFix = 5

function resize.down(d)
  local win = window.focusedWindow()
  if win == nil then
      return
  end

  local screen = win:screen()
  local dimensions = monitors.get_screen_dimensions(screen)
  local dostep = math.ceil(dimensions.h / verticalSplits)

  if d.y == dimensions.y and d.h + dostep < dimensions.h then
    local newH = d.h + dostep
    return {
        x = d.x,
        y = d.y,
        h = newH,
        w = d.w,
    }
  elseif d.y == dimensions.y then
    local newH = dostep
    return {
        x = d.x,
        y = d.y,
        h = newH,
        w = d.w,
    }
  elseif d.y + d.h >= dimensions.y + dimensions.h - allowedPixelOffset and d.h + dostep < dimensions.h then
    local newY = d.y + dostep
    local newH = dimensions.h + dimensions.y - newY
    return {
        x = d.x,
        y = newY,
        h = newH,
        w = d.w,
    }
  elseif d.y + d.h >= dimensions.y + dimensions.h - allowedPixelOffset then
    local newY = dimensions.y + dostep
    local newH = dimensions.h - dostep
    return {
        x = d.x,
        y = newY,
        h = newH,
        w = d.w,
    }
  else
    alert.show("? " .. d.y .. " - " .. d.h .. " - " .. dimensions.h .. " - " .. dimensions.y)
    return {
      x = d.x,
      y = d.y,
      h = d.h,
      w = d.w,
    }
  end
end

function resize.up(d)
  local win = window.focusedWindow()
  if win == nil then
      return
  end

  local screen = win:screen()
  local dimensions = monitors.get_screen_dimensions(screen)
  local dostep = math.ceil(dimensions.h / verticalSplits)

  if d.y == dimensions.y and d.h - dostep > dimensions.x then
    local newH = d.h - dostep
    return {
        x = d.x,
        y = d.y,
        h = newH,
        w = d.w,
    }
  elseif d.y == dimensions.y then
    local newH = dimensions.h - dostep
    return {
        x = d.x,
        y = d.y,
        h = newH,
        w = d.w,
    }
  elseif d.y + d.h >= dimensions.y + dimensions.h - allowedPixelOffset and d.h + dostep < dimensions.h then
    local newY = d.y - dostep
    local newH = d.h + dostep
    return {
        x = d.x,
        y = newY,
        h = newH,
        w = d.w,
    }
  elseif d.y + d.h >= dimensions.y + dimensions.h - allowedPixelOffset then
    local newY = dimensions.y + dimensions.h - dostep
    local newH = dostep
    return {
        x = d.x,
        y = newY,
        h = newH,
        w = d.w,
    }
  else
    alert.show("? " .. d.y .. " - " .. d.h .. " - " .. dimensions.h .. " - " .. dimensions.y)
    return {
      x = d.x,
      y = d.y,
      h = d.h,
      w = d.w,
    }
  end
end

function resize.right(d)
  local win = window.focusedWindow()
  if win == nil then
      return
  end

  local screen = win:screen()
  local dimensions = monitors.get_screen_dimensions(screen)
  local dostep = math.ceil(dimensions.w / horizontalSplits)

  if d.x == dimensions.x and d.w + dostep < dimensions.w then
    local newW = d.w + dostep
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = newW,
    }
  elseif d.x == dimensions.x then
    local newW = dostep
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = newW,
    }
  elseif d.x + d.w >= dimensions.w - allowedPixelOffset and d.x + dostep < dimensions.w then
    local newX = d.x + dostep
    local newW = dimensions.w - newX
    return {
        x = newX,
        y = d.y,
        h = d.h,
        w = dimensions.w - newX,
    }
  elseif d.x + d.w >= dimensions.w - allowedPixelOffset then
    local newX = dostep
    local newW = dimensions.w - dostep
    return {
        x = dostep,
        y = d.y,
        h = d.h,
        w = dimensions.w - dostep,
    }
  else
    alert.show("? " .. d.x .. " - " .. d.w .. " - " .. dimensions.w)
    return {
      x = d.x,
      y = d.y,
      h = d.h,
      w = d.w,
    }
  end
end

function resize.left(d)
  local win = window.focusedWindow()
  if win == nil then
      return
  end

  local screen = win:screen()
  local dimensions = monitors.get_screen_dimensions(screen)
  local dostep = math.ceil(dimensions.w / horizontalSplits)

  if d.x == dimensions.x and d.w - dostep >= dostep then
    local newW = d.w - dostep
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = newW,
    }
  elseif d.x == dimensions.x then
    local newW = dimensions.w - dostep
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = newW,
    }
  elseif d.x + d.w >= dimensions.x + dimensions.w - allowedPixelOffset and d.x - dostep > dimensions.x then
    local newX = d.x - dostep
    local newW = d.w + dostep
    return {
        x = newX,
        y = d.y,
        h = d.h,
        w = newW,
    }
  elseif d.x + d.w >= dimensions.x + dimensions.w - allowedPixelOffset then
    local newX = dimensions.w - dostep
    local newW = dimensions.w - newX
    return {
        x = newX,
        y = d.y,
        h = d.h,
        w = newW,
    }
  else
    alert.show("? " .. d.x .. " - " .. d.w .. " - " .. dimensions.w)
    return {
      x = d.x,
      y = d.y,
      h = d.h,
      w = d.w,
    }
  end
end

return resize

