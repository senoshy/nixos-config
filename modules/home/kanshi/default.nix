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
              }
              {
                criteria = "eDP-1";
                status = "disable";
              }
            ];
            #exec = [(toString ./kanshi-workspaces)];
          };
        }
        {
          profile = {
            name = "portable";
            outputs = [
              {
                criteria = "eDP-1";
                mode = "1366x768@59.97Hz";
                position = "0,0";
              }
            ];
          };
        }
      ];
    };
  };
}
