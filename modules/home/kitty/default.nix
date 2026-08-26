{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home.kitty;
in {
  options.home.kitty = {
    enable = lib.mkEnableOption "enable kitty config management";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [kitty];
    home.file."${config.home.homeDirectory}/.config/kitty/kitty.conf".source = ./kitty.conf;
  };
}
