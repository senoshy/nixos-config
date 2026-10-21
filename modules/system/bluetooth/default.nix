{
  lib,
  config,
  ...
}: let
  cfg = config.system.bluetooth;
in {
  options.system.bluetooth = {
    enable = lib.mkEnableOption "enable bluetooth module";
  };

  config = lib.mkIf cfg.enable {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
  };
}
