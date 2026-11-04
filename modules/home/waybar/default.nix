{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.waybar;

  cacheDir = "${config.home.homeDirectory}/.cache/wallust";
  colorsFile = "${cacheDir}/colors-waybar.css";

  # GTK aborts the whole stylesheet when an @import target is missing, so seed
  # the generated palette before every Waybar start. This also covers a wiped
  # ~/.cache, where activation-time seeding alone would not help.
  waybarWrapped = pkgs.writeShellApplication {
    name = "waybar";
    runtimeInputs = [pkgs.coreutils];
    text = ''
      if [ ! -s ${lib.escapeShellArg colorsFile} ]; then
        mkdir -p ${lib.escapeShellArg cacheDir}
        install -m 0644 ${./colors-fallback.css} ${lib.escapeShellArg colorsFile}
      fi
      exec ${lib.getExe pkgs.waybar} "$@"
    '';
  };

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
      package = waybarWrapped;
    };

    home.file =
      {
        ".config/waybar/config".source = ./config;
        # GTK drops the whole stylesheet when an @import target is missing and
        # cannot expand `~`, hence the absolute runtime path.
        ".config/waybar/style.css".text = ''
          @import url("file://${colorsFile}");

          ${builtins.readFile ./style.css}
        '';
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
