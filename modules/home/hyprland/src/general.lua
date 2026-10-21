-- Colours follow the active Caelestia scheme, regenerated from the wallpaper
-- into ~/.config/hypr/scheme/current.lua (by `caelestia scheme`/`wallpaper`).
-- The inline fallback only applies before the shell has written that file.
local scheme
do
    local home = os.getenv("HOME")
    local ok, loaded = pcall(dofile, home .. "/.config/hypr/scheme/current.lua")
    if ok and type(loaded) == "table" and loaded.primary then
        scheme = loaded
    else
        scheme = {
            primary = "c2c1ff",
            onSurfaceVariant = "47464f",
            inversePrimary = "595992",
        }
    end
end

local function rgba(hex, alpha)
    return "rgba(" .. hex .. alpha .. ")"
end

hl.config({
    input = {
        kb_layout     = "us",
        kb_variant    = "",
        kb_model      = "",
        kb_options    = "",
        kb_rules      = "",
        follow_mouse  = 1,
        accel_profile = "flat",
        sensitivity   = 1,
        touchpad      = {
            natural_scroll = false,
        },
    },

    misc = {
        force_default_wallpaper      = 0,
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        animate_mouse_windowdragging = false,
    },

    -- Values mirror the upstream Caelestia dots so the window chrome lines up
    -- with the bar (same gaps, rounding and scheme-derived border colours).
    general = {
        gaps_in          = 5,
        gaps_out         = 10,
        gaps_workspaces  = 20,
        border_size      = 1,
        col              = {
            active_border   = rgba(scheme.primary, "e6"),
            inactive_border = rgba(scheme.onSurfaceVariant, "11"),
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 15,
        rounding_power   = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow           = {
            enabled      = true,
            range        = 15,
            render_power = 4,
            color        = rgba(scheme.inversePrimary or scheme.primary, "10"),
        },
        blur             = {
            enabled  = true,
            size     = 8,
            passes   = 2,
            vibrancy = 0.1696,
            noise    = 0.02,
        },
    },
})
