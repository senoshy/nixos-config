{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.system.fileSystem;
in {
  options.system.fileSystem = {
    enable = lib.mkEnableOption "enable file system support";
  };

  config = lib.mkIf cfg.enable {
    services.udisks2.enable = true;

    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      ntfs3g
      exfat
    ];
  };
}
