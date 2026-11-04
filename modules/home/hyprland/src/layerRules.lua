hl.layer_rule({
  match = { namespace = "hyprpicker" },
  no_anim = true,
})

hl.layer_rule({
  match = { namespace = "selection" },
  no_anim = true,
})

-- Frosted waybar: needs the semi-transparent background in waybar/style.css.
hl.layer_rule({
  match = { namespace = "waybar" },
  blur = true,
  ignore_alpha = 0.1,
})
