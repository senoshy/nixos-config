{pkgs, ...}: {
  imports = [
    ./modules.nix
  ];

  home.username = "riu";
  home.homeDirectory = "/home/riu";

  programs.git = {
    enable = true;
    settings.user.name = "riu";
    settings.user.email = "riu@wiredbeing.com";

    signing = {
      key = "A9B851A736C32C90";
      signByDefault = true;
    };

    settings.url."https://github.com/".insteadOf = [
      "gh:"
      "github:"
    ];

    settings = {
      init.defaultBranch = "master";
    };
  };

  home.packages = with pkgs; [
    piper
    burpsuite
    spotify-player
    fastfetch
    onlyoffice-desktopeditors
    proton-vpn
    bitwarden-desktop
    fuzzel
    quickshell
    awww
    wl-clipboard
    zathura
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    qt6.qtmultimedia
  ];

  programs.obsidian = {
    enable = true;
    defaultSettings = {
      corePlugins = [
        "file-explorer"
        "global-search"
        "command-palette"
      ];
      communityPlugins = [
        pkgs.obsidian-plugins.kanban
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
