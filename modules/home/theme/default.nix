{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.home.theme;
in {
  options.home.theme = {
    enable = lib.mkEnableOption "enable theme module";
  };

  config = lib.mkIf cfg.enable {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = config.home.pointerCursor.name;
        cursor-size = config.home.pointerCursor.size;
      };
    };

    home.pointerCursor = {
      enable = true;
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
      size = 24;
    };

    qt = {
      enable = true;
      platformTheme.name = "qt6ct";
    };

    gtk.enable = true;
    gtk.font = {
      name = "Tahoma";
      size = 9;
    };
    gtk.theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    gtk.cursorTheme = {
      name = config.home.pointerCursor.name;
      package = config.home.pointerCursor.package;
    };
    gtk.iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    home.packages = with pkgs; [
      glib
      gsettings-desktop-schemas
      dconf-editor
      kdePackages.qt6ct
      libsForQt5.qt5ct
      procps
      libadwaita
      gtk4
      adwaita-icon-theme
      tumbler
      ffmpegthumbnailer
    ];

    gtk.gtk3.bookmarks = [
      "file://${config.xdg.userDirs.documents}"
      "file://${config.xdg.userDirs.download}"
      "file://${config.xdg.userDirs.videos}"
      "file://${config.xdg.userDirs.pictures}"
      "file://${config.xdg.userDirs.projects}"
    ];

    home.file."${config.home.homeDirectory}/.config/kdeglobals".text = ''
      [Icons]
      Theme=Papirus-Dark

      [KFileDialog Settings]
      Places Icons Auto-resize=false
      Places Icons Static Size=22
      Preview Thumbnails=true
      Preview Width=280
    '';

    home.file."${config.home.homeDirectory}/.config/qt5ct/qt5ct.conf".text = ''
      [Appearance]
      style=windows
      icon_theme=Papirus-Dark
    '';

    home.file."${config.home.homeDirectory}/.config/qt6ct/qt6ct.conf".text = ''
      [Appearance]
      style=windows
      icon_theme=Papirus-Dark
    '';
  };
}
