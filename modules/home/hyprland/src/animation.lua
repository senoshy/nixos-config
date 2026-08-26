hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("quick", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })

hl.animation({ leaf = "windows",        enabled = true, speed = 4,   bezier = "quick", style = "slide" })
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 4,   bezier = "quick", style = "slide" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 4,   bezier = "quick", style = "slide" })

hl.animation({ leaf = "fade",           enabled = true, speed = 3,   bezier = "quick" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 3,   bezier = "quick" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 3,   bezier = "quick" })

hl.animation({ leaf = "workspaces",     enabled = true, speed = 3,   bezier = "quick", style = "slide" })
hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 3,   bezier = "quick", style = "slide" })
hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 3,   bezier = "quick", style = "slide" })

hl.animation({ leaf = "layers",         enabled = true, speed = 3,   bezier = "quick", style = "slide" })
hl.animation({ leaf = "layersIn",       enabled = true, speed = 3,   bezier = "quick", style = "slide" })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 3,   bezier = "quick", style = "slide" })

hl.animation({ leaf = "border",         enabled = true, speed = 5,   bezier = "quick" })
