hl.on("hyprland.start", function()
  -- rfkill unblock lets Bluetooth/Wi-Fi radios that were soft-blocked at boot
  -- come up without a manual unlock.
  hl.exec_cmd("rfkill unblock all")
  -- Start the Caelestia shell detached; it owns the bar, launcher,
  -- notifications, OSD and background from here on.
  hl.exec_cmd("caelestia shell -d")
end)