{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.rofi;
in {
  options.home.rofi = {
    enable = lib.mkEnableOption "enable rofi config";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi.enable = true;
    home.file.".config/rofi/config.rasi".source = ./config.rasi;
  };
}
