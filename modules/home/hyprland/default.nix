{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.hyprland;
in {
  options.home.hyprland = {
    enable = lib.mkEnableOption "enable hyprland config management";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      extraConfig = builtins.readFile ./hyprland.lua;
    };

    home.file.".config/hypr/src/animation.lua".source = ./src/animation.lua;
    home.file.".config/hypr/src/binds.lua".source = ./src/binds.lua;
    home.file.".config/hypr/src/device.lua".source = ./src/device.lua;
    home.file.".config/hypr/src/dwindle.lua".source = ./src/dwindle.lua;
    home.file.".config/hypr/src/env.lua".source = ./src/env.lua;
    home.file.".config/hypr/src/general.lua".source = ./src/general.lua;
    home.file.".config/hypr/src/scrolling.lua".source = ./src/scrolling.lua;
    home.file.".config/hypr/src/startup.lua".source = ./src/startup.lua;
    home.file.".config/hypr/src/windowRules.lua".source = ./src/windowRules.lua;
    home.file.".config/hypr/src/layerRules.lua".source = ./src/layerRules.lua;

    services = {
      hyprpolkitagent.enable = true;
      hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "qylock-lock";
            before_sleep_cmd = "qylock-lock";
            ignore_dbus_inhibit = false;
          };
          listener = [
            {
              timeout = 600;
              on-timeout = "qylock-lock";
            }
            {
              timeout = 900;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };
      cliphist.enable = true;
    };

    home.packages = with pkgs; [
      hyprshot
      hyprpicker
      grim
      slurp
      swappy
      pavucontrol
      wl-clipboard
    ];

    home.activation.removeShellLeftovers = lib.hm.dag.entryAfter ["writeBoundary"] ''
      for p in \
        "$HOME/.config/matugen" \
        "$HOME/.config/kde-material-you-colors" \
        "$HOME/.config/kitty/theme.conf" \
        "$HOME/.config/kitty/theme" \
        "$HOME/.config/Kvantum" \
        "$HOME/.config/darklyrc" \
        "$HOME/.config/starship.toml" \
        "$HOME/.config/wlogout" \
        "$HOME/.config/dolphinrc" \
        "$HOME/.config/konsolerc" \
        "$HOME/.local/share/xiaomao-shell"; do
        if [ -e "$p" ]; then $DRY_RUN_CMD rm -rf "$p"; fi
      done
    '';
  };
}
