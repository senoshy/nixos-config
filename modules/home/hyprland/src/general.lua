local function rgba(hex, alpha)
    return "rgba(" .. hex .. alpha .. ")"
end

hl.config({
    input = {
        kb_layout      = "us",
        kb_variant     = "",
        kb_model       = "",
        kb_options     = "",
        kb_rules       = "",
        follow_mouse   = 1,
        accel_profile  = "flat",
        sensitivity    = -0.32,
        force_no_accel = false,
        touchpad       = {
            natural_scroll = false,
            scroll_factor  = 1.5,
        },
    },

    misc = {
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        animate_mouse_windowdragging = false,
        enable_swallow               = false,
        allow_session_lock_restore   = true,
    },

    general = {
        gaps_in          = 2,
        gaps_out         = 4,
        gaps_workspaces  = 10,
        border_size      = 2,
        col              = {
            active_border   = rgba("a996ba", "e6"),
            inactive_border = rgba("47464f", "11"),
        },
        resize_on_border = true,
        allow_tearing    = true,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 8,
        rounding_power   = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow           = {
            enabled = false,
        },
        blur             = {
            enabled           = true,
            size              = 3,
            passes            = 1,
            new_optimizations = true,
            noise             = 0.02,
            contrast          = 1.0,
            brightness        = 1.0,
            popups            = true,
        },
    },

    cursor = {
        no_hardware_cursors = false,
    },

    render = {
        -- 2 = auto: direct scanout only for fullscreen games (CONTENT_TYPE_GAME).
        -- With 1/true, browser fullscreen viewers (X/Reddit images) also get
        -- direct-scanned-out, and the AB24 <-> XR24 swapchain change forces a
        -- full modeset on i915, flashing the whole output on every toggle.
        direct_scanout = 2,
    },
})
