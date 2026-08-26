{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.waybar;
in {
  options.home.waybar = {
    enable = lib.mkEnableOption "enable waybar module";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = import ./src/config.jsonc;
      style = import ./src/style.css;
    };
  };
}
