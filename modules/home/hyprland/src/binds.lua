local mainMod = "SUPER"

local terminal = "kitty"
local fileManager = "thunar"

-- Tapping SUPER alone opens the Caelestia launcher (release-only, so it never
-- fires mid-combo). SUPER + R and SUPER + / do the same thing.
hl.bind(mainMod .. " + SUPER_L", hl.dsp.global("caelestia:launcher"), { release = true })

hl.bind(mainMod .. " + L", function()
  local ws = hl.get_active_workspace()
  local current_layout = ws.tiled_layout

  if current_layout == "scrolling" then
    hl.config({ general = { layout = "dwindle" }, input = { follow_mouse = 1 } })
  else
    hl.config({ general = { layout = "scrolling" }, input = { follow_mouse = 0 } })
  end
end)

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd('hyprshot -m region --freeze'))

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + R", hl.dsp.global("caelestia:launcher"))
hl.bind(mainMod .. " + O", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("qylock-lock"), { locked = true })

-- Launcher is bound above; SUPER + / opens it too, like a start key.
hl.bind(mainMod .. " + slash", hl.dsp.global("caelestia:launcher"))

-- Volume/brightness drive the Caelestia shell's OSD: volume via wpctl (the
-- shell renders the widget), brightness through the shell's global shortcut.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"),
  { locked = true, repeating = true })

-- Media keys through the shell so the OSD/toast follow playback.
hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), { locked = true })