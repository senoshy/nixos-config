hl.on("hyprland.start", function()
    hl.exec_cmd("rfkill unblock all")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("awww-daemon")
end)

