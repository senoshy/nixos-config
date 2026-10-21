{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.home.dev.vscodium;
in {
  options.home.dev.vscodium = {
    enable = lib.mkEnableOption "enable vscodium";
  };

  config = lib.mkIf cfg.enable {
    programs.vscodium = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.vscodium;
      profiles.default.enableExtensionUpdateCheck = lib.mkDefault true;
      profiles.default.userSettings = {
        "workbench.colorTheme" = "Default Dark Modern";
      };
    };
  };
}
