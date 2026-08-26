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
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.systemd.enable = false;
    wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland.lua;

    home.file.".config/hypr/src/animation.lua".source = ./src/animation.lua;
    home.file.".config/hypr/src/binds.lua".source = ./src/binds.lua;
    home.file.".config/hypr/src/device.lua".source = ./src/device.lua;
    home.file.".config/hypr/src/dwindle.lua".source = ./src/dwindle.lua;
    home.file.".config/hypr/src/env.lua".source = ./src/env.lua;
    home.file.".config/hypr/src/general.lua".source = ./src/general.lua;
    home.file.".config/hypr/src/scrolling.lua".source = ./src/scrolling.lua;
    home.file.".config/hypr/src/startup.lua".source = ./src/startup.lua;
    home.file.".config/hypr/src/windowRules.lua".source = ./src/windowRules.lua;

    home.packages = with pkgs; [
      hyprshot
      pavucontrol
      hyprpolkitagent
    ];
  };
}
