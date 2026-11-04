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
        "application/x-roblox-place" = "org.vinegarhq.Vinegar.desktop";
        "application/x-roblox-model" = "org.vinegarhq.Vinegar.desktop";
        "x-scheme-handler/roblox-studio" = "org.vinegarhq.Vinegar.desktop";
        "x-scheme-handler/roblox-studio-auth" = "org.vinegarhq.Vinegar.desktop";
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
      ];
    };
  };
}
