{
  config,
  lib,
  ...
}: let
  cfg = config.home.kanshi;
in {
  options.home.kanshi = {
    enable = lib.mkEnableOption "enable kanshi module";
  };
  config = lib.mkIf cfg.enable {
    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
      settings = [
        {
          profile = {
            name = "home";
            outputs = [
              {
                criteria = "HDMI-A-1";
                mode = "1920x1080@120Hz";
                position = "0,0";
              }
              {
                criteria = "eDP-1";
                status = "disable";
              }
            ];
          };
        }
        {
          profile = {
            name = "portable";
            outputs = [
              {
                criteria = "eDP-1";
                mode = "1360x768@60Hz";
                position = "0,0";
              }
            ];
          };
        }
      ];
    };
  };
}
