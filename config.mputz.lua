local config = {}

config.modules = {
    "arrows",
    "monitors",
    "monitors_switch",
    "auto_reload",
    "repl",
    "resize",
    "fullscreen"
}

-- Maps monitor id -> screen index.
config.monitors = {
    autodiscover = true,
    rows = 1
}

-- Arrows
config.arrows = {
    mash = { "ctrl", "alt" },
    keys = {
        K = "top",
        J = "bottom",
        H = "left",
        L = "right",
        B = "full",
        U = "top_left",
        I = "middle_third",
        O = "top_right",
        M = "bottom_right",
        N = "bottom_left"
    }
}

-- Monitors Switch
config.monitors_switch = {
    mash = { "cmd", "ctrl", "shift" },
    key = "SPACE"
}

-- Resize
config.resize = {
    mash = { "cmd", "alt" },
    keys = {
        K = "up",
        J = "down",
        H = "left",
        L = "right"
    }
}

return config
