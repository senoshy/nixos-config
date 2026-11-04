{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.hyprland;

  # 0.57 dropped `hyprctl keyword`, so set the option through the Lua config API.
  # Without it a locker cannot take the lock after Hyprland restarts into a
  # locked session, which leaves a lockdead screen nobody can unlock.
  qylockRestore = pkgs.writeShellScriptBin "qylock-lock-restore" ''
    hyprctl eval 'hl.config({ misc = { allow_session_lock_restore = true } })' >/dev/null 2>&1 || true
    exec qylock-lock "$@"
  '';
in {
  options.home.hyprland = {
    enable = lib.mkEnableOption "enable hyprland config management";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      extraConfig = builtins.readFile ./hyprland.lua;
    };

    home.file.".config/hypr/src/animation.lua".source = ./src/animation.lua;
    home.file.".config/hypr/src/binds.lua".source = ./src/binds.lua;
    home.file.".config/hypr/src/device.lua".source = ./src/device.lua;
    home.file.".config/hypr/src/dwindle.lua".source = ./src/dwindle.lua;
    home.file.".config/hypr/src/env.lua".source = ./src/env.lua;
    home.file.".config/hypr/src/general.lua".source = ./src/general.lua;
    home.file.".config/hypr/src/scrolling.lua".source = ./src/scrolling.lua;
    home.file.".config/hypr/src/startup.lua".source = ./src/startup.lua;
    home.file.".config/hypr/src/windowRules.lua".source = ./src/windowRules.lua;
    home.file.".config/hypr/src/layerRules.lua".source = ./src/layerRules.lua;
    home.file.".config/mako/config".text = ''
      font=monospace 10
      background-color=#0d0c0c
      text-color=#fff7e2
      border-color=#a996ba
      border-size=1
      border-radius=0
      default-timeout=5000
      anchor=top-right
      margin=8
      padding=8
    '';

    services = {
      hyprpolkitagent.enable = true;
      hypridle = {
        enable = false;
        settings = {
          general = {
            lock_cmd = "qylock-lock-restore";
            before_sleep_cmd = "qylock-lock-restore";
            ignore_dbus_inhibit = false;
          };
          listener = [
            {
              timeout = 600;
              on-timeout = "qylock-lock-restore";
            }
            {
              timeout = 900;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };
      cliphist.enable = true;
    };

    home.packages = with pkgs; [
      qylockRestore
      hyprshot
      hyprpicker
      grim
      slurp
      swappy
      pavucontrol
      wl-clipboard
      mako
      libnotify
      awww
    ];

    home.activation.reloadHyprland = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if command -v hyprctl >/dev/null 2>&1 && [ -n "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
        $DRY_RUN_CMD hyprctl reload >/dev/null 2>&1 || true
      fi
    '';
  };
}
