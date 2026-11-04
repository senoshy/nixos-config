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
      package = pkgs.macos-tahoe-cursors;
      name = "MacOS-Tahoe-Cursor";
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
      [General]
      ColorScheme=BreezeDark

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

    home.activation.removeOldThemeLeftovers = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD rm -rf -- \
        "$HOME/.cache/caelestia" \
        "$HOME/.cache/quickshell" \
        "$HOME/.cache/hellwal" \
        "$HOME/.config/qtengine" \
        "$HOME/.config/spicetify/Themes/caelestia" \
        "$HOME/.config/btop/themes/caelestia.theme" \
        "$HOME/.config/zed/themes/caelestia.json" \
        "$HOME/.config/Equicord/themes/caelestia.theme.css" \
        "$HOME/.config/Vencord/themes/caelestia.theme.css" \
        "$HOME/.config/BetterDiscord/themes/caelestia.theme.css" \
        "$HOME/.config/equibop/themes/caelestia.theme.css" \
        "$HOME/.config/vesktop/themes/caelestia.theme.css" \
        "$HOME/.config/legcord/themes/caelestia.theme.css" \
        "$HOME/.local/share/PandoraLauncher/themes/caelestia.json" \
        "$HOME/.local/share/warp-terminal/themes/caelestia.yaml" \
        "$HOME/.config/nvim/lua/caelestia.lua" \
        "$HOME/.config/nvim/colors/caelestia.lua" \
        "$HOME/.config/nvim/lua/lualine/themes/caelestia.lua" \
        "$HOME/.config/sway" \
        "$HOME/.config/labwc" \
        "$HOME/.config/lxqt" \
        "$HOME/.config/pcmanfm-qt" \
        "$HOME/.config/fuzzel"
      $DRY_RUN_CMD rm -f -- \
        "$HOME"/.config/hypr/src/*.bak \
        "$HOME"/.config/hypr/src/*.back \
        "$HOME"/.config/hypr/src/*.bask
    '';
  };
}
