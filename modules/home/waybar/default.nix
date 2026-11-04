{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.waybar;

  # Scripts referenced from config (custom/now-playing, custom/playerctl).
  scripts = {
    "now-playing.sh" = ./scripts/now-playing.sh;
    "playerctl_scroll.sh" = ./scripts/playerctl_scroll.sh;
  };
in {
  options.home.waybar = {
    enable = lib.mkEnableOption "enable waybar config";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };

    home.file =
      {
        ".config/waybar/config".source = ./config;
        ".config/waybar/style.css".source = ./style.css;
      }
      // lib.mapAttrs' (
        name: source:
          lib.nameValuePair ".config/waybar/scripts/${name}" {
            inherit source;
            executable = true;
          }
      )
      scripts;
  };
}
