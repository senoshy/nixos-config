{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.dev;
in {
  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = lib.mkDefault true;
      extensions = [
        "live-server"
        "nix"
      ];
      extraPackages = with pkgs; [
        nix-d
      ];
      userSettings = {
        ui_font_size = 14;
        ui_font_family = "Ligconsolata";
        buffer_font_size = 14;
        telemetry = {
          metrics = false;
        };
      };
    };
  };
}
