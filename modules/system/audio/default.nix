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

      lowLatency = {
        enable = true;
        quantum = 512;
        rate = 48000;
      };
    };

    services.pipewire.wireplumber.extraConfig."10-disable-suspending" = {
      "monitor.alsa.rules" = [
        {
          matches = [{"node.name" = "~alsa_output.*";}];
          actions = {
            update-props = {
              "session.suspend-on-idle" = false;
            };
          };
        }
      ];
    };

    environment.systemPackages = with pkgs; [
      playerctl
    ];
  };
}
