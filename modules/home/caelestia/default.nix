{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home.caelestia;

  shellSettings = {
    general = {
      apps = {
        terminal = ["kitty"];
        audio = ["pavucontrol"];
        explorer = ["thunar"];
      };

      idle = {
        timeouts = [];
        lockBeforeSleep = false;
      };
    };
    lock.enabled = false;

    paths.wallpaperDir = "~/pictures/Wallpapers";
  };
in {
  imports = [inputs.caelestia-shell.homeManagerModules.default];

  options.home.caelestia = {
    enable = lib.mkEnableOption "enable caelestia shell";
  };

  config = lib.mkIf cfg.enable {
    home.file."${config.home.homeDirectory}/.config/caelestia/templates/kitty.conf".source =
      ./templates/kitty.conf;
    home.file."${config.home.homeDirectory}/.config/caelestia/templates/nvim.lua".source =
      ./templates/nvim.lua;

    programs.caelestia = {
      enable = true;

      systemd.enable = false;

      cli = {
        enable = true;

        settings.theme.postHook = "hyprctl reload";
      };
    };

    home.activation.caelestiaShellJson = lib.hm.dag.entryAfter ["linkGeneration"] ''
      cfg="$HOME/.config/caelestia/shell.json"
      if [ ! -e "$cfg" ] || [ -L "$cfg" ]; then
        mkdir -p "$(dirname "$cfg")"
        rm -f "$cfg"
        printf '%s' ${lib.escapeShellArg (builtins.toJSON shellSettings)} > "$cfg"
        chmod u+w "$cfg"
      fi
    '';

    home.activation.caelestiaRestartShell = lib.hm.dag.entryAfter ["linkGeneration"] ''
      if [ -n "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ] && [ -n "''${WAYLAND_DISPLAY:-}" ] \
        && ${pkgs.procps}/bin/pgrep -f "/share/caelestia-shell" >/dev/null 2>&1; then
        $DRY_RUN_CMD ${pkgs.procps}/bin/pkill -f "/share/caelestia-shell" || true
        sleep 1
        $DRY_RUN_CMD env \
          PATH="${config.home.profileDirectory}/bin:/run/current-system/sw/bin:/run/wrappers/bin''${PATH:+:$PATH}" \
          QS_ICON_THEME=Papirus-Dark \
          ${config.programs.caelestia.package}/bin/caelestia-shell -n -d >/dev/null 2>&1 &
      fi
    '';
  };
}
