{
  config,
  lib,
  ...
}: let
  cfg = config.system.input;
in {
  options.system.input = {
    enable = lib.mkEnableOption "enable input device tuning";

    disableMouseDebounce = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Disable libinput button debounce for mice. Fixes clicks feeling
        "held"/drags starting by themselves when the mouse switch produces a
        little bounce that libinput tries to debounce (Windows drivers don't).
        Mainline libinput disables debounce when the device is marked as a
        "bouncing keys" device (ModelBouncingKeys=1).
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc."libinput/local-overrides.quirks".text = lib.mkIf cfg.disableMouseDebounce ''
      # Disable libinput button debounce: keeps clicks from being held/dragging.
      [No Mouse Button Debounce]
      MatchUdevType=mouse
      ModelBouncingKeys=1
    '';
  };
}