{
  config,
  lib,
  ...
}: let
  cfg = config.system.boot;
in {
  options.system.boot = {
    enable = lib.mkEnableOption "enables grub";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.configurationLimit = 10;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
  };
}
