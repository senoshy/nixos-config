{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.system.interface;
  cursorPackage = pkgs.macos-tahoe-cursors;
  cursorThemeName = "MacOS-Tahoe-Cursor";
in {
  options.system.interface = {
    enable = lib.mkEnableOption "sddm, hyprland, and gnome-keyring";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.defaultSession = lib.mkDefault "hyprland-uwsm";

    services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland = {
        enable = lib.mkDefault true;
        compositor = lib.mkDefault "kwin";
      };
      settings = {
        Theme = {
          CursorTheme = cursorThemeName;
          CursorSize = 24;
        };
      };
    };

    systemd.services.display-manager.environment = {
      XCURSOR_PATH = "${cursorPackage}/share/icons:/run/current-system/sw/share/icons";
      XCURSOR_THEME = cursorThemeName;
      XCURSOR_SIZE = "24";
    };

    programs.qylock = {
      enable = true;
      theme = "nier-automata";
    };

    services.gnome.gnome-keyring.enable = lib.mkDefault true;
    services.dbus.implementation = lib.mkDefault "broker";

    security.pam.services = {
      sddm.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };

    environment.systemPackages = with pkgs; [
      cursorPackage
      gnome-epub-thumbnailer
    ];

    environment.sessionVariables = {
      XCURSOR_THEME = cursorThemeName;
      XCURSOR_SIZE = "24";
    };

    programs.hyprland.enable = lib.mkDefault true;
    programs.hyprland.withUWSM = lib.mkDefault true;
  };
}
