{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.home.media;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.spicetify];
  options.home.media = {
    enable = lib.mkEnableOption "enable some media (media player, social media, etc)";
  };

  config = lib.mkIf cfg.enable {
    programs.spicetify = {
      enable = lib.mkDefault true;
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        shuffle
      ];
      wayland = lib.mkDefault null;
      windowManagerPatch = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };

    xdg.desktopEntries."element-desktop" = {
      name = "Element";
      type = "Application";
      exec = "element-desktop --password-store=gnome-libsecret %U";
      icon = "element-desktop";
      categories = ["Network" "InstantMessaging"];
      mimeType = ["x-scheme-handler/matrix"];
      startupNotify = true;
    };

    xdg.desktopEntries."spotify" = {
      name = "Spotify";
      type = "Application";
      icon = "spotify-client";
      exec = "env -u DISPLAY spotify %U";
      categories = ["Audio" "Music" "Player" "AudioVideo"];
      mimeType = ["x-scheme-handler/spotify"];
      startupNotify = true;
    };

    home.packages = with pkgs; [
      qview
      zathura
      kdePackages.kservice
      krita
      element-desktop
      discord
      telegram-desktop
    ];

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
      $DRY_RUN_CMD kbuildsycoca6 --noincremental || true
    '';
  };
}
