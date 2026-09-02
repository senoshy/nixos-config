{
  inputs,
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

    home.sessionVariables = {
      XCURSOR_THEME = config.home.pointerCursor.name;
      XCURSOR_SIZE = toString config.home.pointerCursor.size;
    };

    home.pointerCursor = {
      enable = true;
      package = pkgs.kdePackages.breeze;
      name = "Breeze_Light";
      size = 18;
    };

    qt = {
      enable = true;
      platformTheme.name = "qt6ct";
    };

    gtk.enable = true;
    gtk.theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    gtk.iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    home.packages = with pkgs; [
      glib
      gsettings-desktop-schemas
      dconf-editor
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      adw-gtk3
      procps
      libadwaita
      gtk4
      papirus-icon-theme
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

    gtk.gtk3.extraCss = lib.mkForce ''
      @import url("file://${config.home.homeDirectory}/.config/gtk-3.0/colors.css");
    '';

    gtk.gtk4.extraCss = lib.mkForce ''
      @import url("file://${config.home.homeDirectory}/.config/gtk-4.0/colors.css");
    '';

    home.file."${config.home.homeDirectory}/.config/kdeglobals".text = ''
      [UiSettings]
      ColorScheme=Matugen

      [Icons]
      Theme=Papirus-Dark

      [KFileDialog Settings]
      Places Icons Auto-resize=false
      Places Icons Static Size=22
      Preview Thumbnails=true
      Preview Width=280

      [KDE File Manager Settings]
      image/jpeg=com.interversehq.qView.desktop
      image/png=com.interversehq.qView.desktop
      image/gif=com.interversehq.qView.desktop
      image/bmp=com.interversehq.qView.desktop
      image/webp=com.interversehq.qView.desktop
      image/tiff=com.interversehq.qView.desktop
      image/avif=com.interversehq.qView.desktop
    '';

    home.file."${config.home.homeDirectory}/.config/qt5ct/qt5ct.conf".text = ''
      [Appearance]
      style=kvantum
      color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/matugen.conf
      icon_theme=Papirus-Dark
      custom_palette=true
    '';

    home.file."${config.home.homeDirectory}/.config/qt6ct/qt6ct.conf".text = ''
      [Appearance]
      style=kvantum
      color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/matugen.conf
      icon_theme=Papirus-Dark
      custom_palette=true
    '';

    home.file."${config.home.homeDirectory}/.config/Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=matugen
    '';
  };
}
