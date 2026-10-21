{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.home.browsers;
in {
  imports = [./firefox.nix];

  options.home.browsers = {
    defaultBrowser = lib.mkOption {
      type = lib.types.enum ["firefox" "chromium"];
      default = "firefox";
      description = "Which installed browser is the default for http/https/html mime types.";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.mimeApps = {
      enable = lib.mkDefault true;
      defaultApplications = lib.mkIf (cfg.defaultBrowser == "firefox") {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}
