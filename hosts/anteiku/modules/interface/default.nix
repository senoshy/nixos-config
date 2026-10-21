{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.system.interface;
  cursorPackage = pkgs.whitesur-cursors;
  cursorThemeName = "WhiteSur-cursors";
in {
  options.system.interface = {
    enable = lib.mkEnableOption "sddm, hyprland, and gnome-keyring";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland = {
        enable = lib.mkDefault true;
        compositor = "kwin";
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
      theme = "enfield";
      themeOptions = {
        terraria.backgroundMode = "time";
        Genshin.backgroundMode = "time";
        clockwork.orbital = {
          themeMode = "dark";
          enableWindup = true;
        };
        osu.gameMode = "menu";
      };
    };

    services.gnome.gnome-keyring.enable = lib.mkDefault true;
    services.dbus.implementation = lib.mkDefault "broker";

    security.pam.services = {
      sddm.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };

    environment.systemPackages = with pkgs; [
      xinit
      cursorPackage
      gnome-epub-thumbnailer
      kdePackages.kwindowsystem
      kdePackages.qt5compat
      kdePackages.qtmultimedia
      qt5.qtgraphicaleffects
      qt5.qtquickcontrols
      qt5.qtsvg
    ];

    environment.sessionVariables = {
      XCURSOR_THEME = cursorThemeName;
      XCURSOR_SIZE = "24";
    };

    programs.hyprland.enable = lib.mkDefault true;
    programs.hyprland.withUWSM = lib.mkDefault true;
  };
}
