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
        nixd
      ];
      userSettings = {
        ui_font_size = 14;
        ui_font_family = "Liga SFMono Nerd Font";
        buffer_font_size = 14;
        buffer_font_family = "Liga SFMono Nerd Font";
        telemetry = {
          metrics = false;
        };
      };
    };
  };
}
