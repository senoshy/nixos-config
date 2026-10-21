{
  config,
  pkgs,
  lib,
  ...
}: {
  options.home.media = {
    enable = lib.mkEnableOption "enable some media (media player, social media, etc)";
  };

  config = lib.mkIf config.home.media.enable {
    services.easyeffects.enable = true;

    home.packages = with pkgs; [
      qview
      zathura
      kdePackages.kservice
      krita
      element-desktop
      discord
      telegram-desktop
      vlc
      yt-dlp
      mpv
      ffmpeg
    ];

    xdg.desktopEntries."element-desktop" = {
      name = "Element";
      type = "Application";
      exec = "element-desktop --password-store=gnome-libsecret %U";
      icon = "element-desktop";
      categories = ["Network" "InstantMessaging"];
      mimeType = ["x-scheme-handler/matrix"];
      startupNotify = true;
    };

    home.file."${config.home.homeDirectory}/.config/menus/applications.menu".text = ''
      <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
       "http://www.freedesktop.org/standards/menu-spec/menu-1.0.dtd">
      <Menu>
        <Name>Applications</Name>
        <DefaultAppDirs/>
        <DefaultDirectoryDirs/>
        <DefaultMergeDirs/>
        <Include>
          <All/>
        </Include>
      </Menu>
    '';

    home.activation.kbuildsycoca = lib.mkAfter ''
      $DRY_RUN_CMD ${pkgs.kdePackages.kservice}/bin/kbuildsycoca6 --noincremental || true
    '';
  };
}
