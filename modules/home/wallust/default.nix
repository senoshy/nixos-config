{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.wallust;

  stateDir = "${config.home.homeDirectory}/.local/state/wallust";
  wallpaperState = "${stateDir}/last-wallpaper";
  hyprlandColors = "${config.home.homeDirectory}/.cache/wallust/hyprland-colors.lua";

  runtimeInputs = with pkgs; [
    awww
    coreutils
    hyprland
    procps
    wallust
  ];

  # Apply a wallpaper, regenerate the palette from it, push the border colours
  # into the running compositor and make Waybar re-read its CSS. Use this
  # instead of calling `awww img` directly.
  wallpaperSet = pkgs.writeShellApplication {
    name = "wallpaper-set";
    inherit runtimeInputs;
    text = ''
      if [ "$#" -ne 1 ]; then
        echo "usage: wallpaper-set <image>" >&2
        exit 2
      fi

      if [ ! -f "$1" ]; then
        echo "wallpaper-set: no such file: $1" >&2
        exit 1
      fi

      image="$(realpath "$1")"
      mkdir -p "${stateDir}"

      awww img "$image"
      printf '%s\n' "$image" > "${wallpaperState}"
      wallust run --skip-sequences "$image"
      if [ -s "${hyprlandColors}" ]; then
        hyprctl eval "$(cat "${hyprlandColors}")" >/dev/null 2>&1 || true
      fi
      pkill -SIGUSR2 -x waybar || true
    '';
  };

  # Re-apply the last wallpaper at session start. awww-daemon is started in
  # parallel by Hyprland, so wait for it before sending the image.
  wallpaperRestore = pkgs.writeShellApplication {
    name = "wallpaper-restore";
    inherit runtimeInputs;
    text = ''
      [ -r "${wallpaperState}" ] || exit 0

      image="$(cat "${wallpaperState}")"
      [ -f "$image" ] || exit 0

      for _ in {1..50}; do
        awww query >/dev/null 2>&1 && break
        sleep 0.1
      done

      awww img "$image"
      wallust run --skip-sequences "$image"
      if [ -s "${hyprlandColors}" ]; then
        hyprctl eval "$(cat "${hyprlandColors}")" >/dev/null 2>&1 || true
      fi
      pkill -SIGUSR2 -x waybar || true
    '';
  };
in {
  options.home.wallust = {
    enable = lib.mkEnableOption "enable wallpaper-driven wallust palettes";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        pkgs.wallust
        wallpaperSet
        wallpaperRestore
      ];

      file = {
        ".config/wallust/wallust.toml".source = ./wallust.toml;
        ".config/wallust/templates/waybar-colors.css".source = ./templates/waybar-colors.css;
        ".config/wallust/templates/hyprland-colors.lua".source = ./templates/hyprland-colors.lua;
        ".config/wallust/templates/rofi-colors.rasi".source = ./templates/rofi-colors.rasi;
      };
    };
  };
}
