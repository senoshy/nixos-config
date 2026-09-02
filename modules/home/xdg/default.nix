{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.home.xdg;
in {
  options.home.xdg = {
    enable = lib.mkEnableOption "enable xdg module";
  };

  config = lib.mkIf cfg.enable {
    xdg.enable = true;
    xdg.userDirs = let
      homeDir = path: "${config.home.homeDirectory}/${path}";
    in {
      enable = true;
      createDirectories = true;
      download = homeDir "downloads";
      documents = homeDir "documents";
      videos = homeDir "videos";
      pictures = homeDir "pictures";
      desktop = homeDir "desktop";
      projects = homeDir "projects";
      music = "$HOME";
      templates = "$HOME";
      publicShare = "$HOME";
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
        "image/jpeg" = "com.interversehq.qView.desktop";
        "image/png" = "com.interversehq.qView.desktop";
        "image/gif" = "com.interversehq.qView.desktop";
        "image/bmp" = "com.interversehq.qView.desktop";
        "image/webp" = "com.interversehq.qView.desktop";
        "image/tiff" = "com.interversehq.qView.desktop";
        "image/avif" = "com.interversehq.qView.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };

    xdg.portal = {
      enable = true;
      config = {
        common.default = "*";

        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
          "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
        };
      };

      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ];
    };
  };
}
