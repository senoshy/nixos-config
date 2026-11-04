{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.gaming;
in {
  options.system.gaming = {
    enable = lib.mkEnableOption "enable gaming module";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      dedicatedServer.openFirewall = true;
      platformOptimizations.enable = true;
      extraPackages = [pkgs.gamescope];
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

    programs.gamescope.enable = true;

    systemd.services.sober-install = {
      description = "Install Sober from Flathub (Initial Setup)";
      wants = ["network-online.target"];
      after = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];

      script = ''
        set -eu

        # Exit early if initial setup was already completed
        if [ -f /var/lib/sober-installed ]; then
          echo "Sober initial installation already completed. Exiting."
          exit 0
        fi

        flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

        if ! flatpak info --system org.vinegarhq.Sober >/dev/null 2>&1; then
          flatpak install --system --noninteractive --assumeyes flathub org.vinegarhq.Sober
        fi

        # Create marker file to signal successful completion
        touch /var/lib/sober-installed
      '';

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        TimeoutStartSec = "20min";
      };
    };

    environment.systemPackages = with pkgs; [
      heroic
      lutris
      bottles
      prismlauncher
      inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
      r2modman
    ];
  };
}
