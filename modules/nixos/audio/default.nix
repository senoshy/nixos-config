{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.audio;
in {
  options.system.audio = {
    enable = lib.mkEnableOption "enable audio module";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      playerctl
    ];
  };
}
