hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
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
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  name   = "xdg-file-picker-save",
  match  = {
    class = "xdg-desktop-portal-gtk",
    title = "Enter name of file to save to….*",
  },
  float  = true,
  size   = { 800, 600 },
  center = true,
})

hl.window_rule({
  name   = "xdg-file-chooser",
  match  = {
    class = "xdg-desktop-portal-gtk",
    title = "Open File.*",
  },
  float  = true,
  size   = { 800, 600 },
  center = true,
})

hl.window_rule({
  name = "xdg-desktop-upload",
  match = {
    class = "xdg-desktop-portal-gtk",
    title = "File Upload.*",
  },
  float = true,
  size = { 800, 600 },
  center = true,
})

hl.window_rule({
  name = "Opening firefox",
  match = {
    class = "firefox",
    title = "Opening.*",
  },
  float = true,
  size = { 600, 300 },
  center = true,
})
