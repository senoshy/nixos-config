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
      settings = {
        mainBar = builtins.fromJSON (builtins.readFile ./src/config.json);
      };
      style = ./src/style.css;
    };
  };
}
