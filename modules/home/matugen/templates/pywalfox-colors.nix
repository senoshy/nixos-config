{
  config,
  lib,
  matugenAbsPath,
  ...
}: {
  config = lib.mkIf config.home.matugen.enable {
    home.file."${matugenAbsPath}/pywalfox-colors.json".text = ''
      {
        "wallpaper": "{{image}}",
        "alpha": "100",
        "colors": {
          "color0": "{{m3.surface.default.hex}}",
          "color1": "{{m3.error.default.hex}}",
          "color2": "{{m3.success.default.hex}}",
          "color3": "{{m3.tertiary.default.hex}}",
          "color4": "{{m3.primary.default.hex}}",
          "color5": "{{m3.secondary.default.hex}}",
          "color6": "{{m3.outline.default.hex}}",
          "color7": "{{m3.on_surface.default.hex}}",
          "color8": "{{m3.surface_container_high.default.hex}}",
          "color9": "{{m3.error.default.hex}}",
          "color10": "{{m3.success.default.hex}}",
          "color11": "{{m3.tertiary.default.hex}}",
          "color12": "{{m3.primary.default.hex}}",
          "color13": "{{m3.secondary.default.hex}}",
          "color14": "{{m3.outline.default.hex}}",
          "color15": "{{m3.on_surface.default.hex}}"
        }
      }
    '';
  };
}
