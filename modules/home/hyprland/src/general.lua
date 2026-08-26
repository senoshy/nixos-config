local colors = dofile(os.getenv("HOME") .. "/.config/hypr/colors.lua")

hl.config({
  input = {
    kb_layout      = "us",
    kb_variant     = "",
    kb_model       = "",
    kb_options     = "",
    kb_rules       = "",
    follow_mouse   = 1,
    force_no_accel = 1,
    accel_profile  = "flat",
    sensitivity    = 0.9,
    touchpad       = {
      natural_scroll = false,
    },
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo   = true,
  },

  general = {
    gaps_in          = 8,
    gaps_out         = 8,
    border_size      = 0,
    col              = {
      active_border   = colors.primary,
      inactive_border = colors.on_surface,
    },
    resize_on_border = false,
    allow_tearing    = false,
    layout           = "dwindle",
  },

  decoration = {
    rounding         = 0,
    rounding_power   = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow           = {
      enabled      = false,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },
    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 2,
      vibrancy = 0.1696,
      noise    = 0.02,
    },
  },
})
