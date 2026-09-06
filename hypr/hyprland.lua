-- Hyprland Lua config (Hyprland >= 0.55), ported from hyprland.conf.
-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- Fallback for any monitor; DMS-managed outputs are required at the bottom
-- and take precedence for the monitors they name.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty"
local fileManager = "nautilus"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- NixOS ships hyprpolkitagent as a systemd user unit
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
    hl.exec_cmd("dms run")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Static palette (gruvbox dark); require("dms.colors") at the bottom of
-- this file instead if you want DMS/matugen to drive the border colors.
local yellow = "rgba(d79921ff)"
local gray   = "rgba(928374ff)"

hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 6,

        border_size = 3,

        col = {
            active_border   = yellow,
            inactive_border = gray,
        },

        resize_on_border = true,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 12,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range   = 20,
            color   = "rgba(00000099)",
        },

        blur = {
            enabled = true,
            size    = 6,
            passes  = 2,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo = true,
    },

    group = {
        col = {
            border_active   = yellow,
            border_inactive = gray,
        },

        groupbar = {
            gradients     = true,
            gaps_in       = 0,
            gaps_out      = 0,
            font_size     = 11,
            font_family   = "iMWritingQuat Nerd Font Propo",
            text_color    = "rgb(282828)",
            text_color_inactive = "rgb(ebdbb2)",
            keep_upper_gap = false,
            blur          = true,
            rounding      = 0,

            col = {
                active   = yellow,
                inactive = gray,
            },
        },
    },
})

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("ghostty --title=floatingterm"))

hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.close())
hl.bind(mainMod .. " + M",         hl.dsp.exit())
hl.bind(mainMod .. " + Space",     hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind(mainMod .. " + O",         hl.dsp.exec_cmd("dms ipc call hypr openOverview"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("dms ipc call powermenu open"))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T",         hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + Z",         hl.dsp.group.toggle())
hl.bind(mainMod .. " + less",      hl.dsp.group.next())
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move windows (group-aware, like movewindoworgroup)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left",  group_aware = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up",    group_aware = true }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down",  group_aware = true }))

-- Switch workspaces / move window to workspace
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratch" }))

-- Scroll through workspaces (PgDn / PgUp)
hl.bind(mainMod .. " + Next",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + Prior", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Media
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "floatingterm",
    match = {
        class = "com.mitchellh.ghostty",
        title = "floatingterm",
    },

    float = true,
    size  = "900 500",
})

--------------------------
---- DMS INTEGRATION -----
--------------------------

-- DMS regenerates these as Lua modules in hypr/dms/ once it sees a Lua
-- config. pcall keeps startup clean if a module doesn't exist yet.
pcall(require, "dms.cursor")
pcall(require, "dms.outputs")

-- Uncomment to let DMS/matugen theme borders and gaps instead of the
-- static palette above:
-- require("dms.colors")
-- require("dms.layout")
