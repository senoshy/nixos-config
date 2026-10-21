{
  pkgs,
  ...
}: {
  imports = [
    ./modules.nix
  ];

  home.username = "senoshy";
  home.homeDirectory = "/home/senoshy";

  programs.git = {
    enable = true;

    signing = {
      key = "A9B851A736C32C90";
      signByDefault = true;
    };

    settings = {
      user.name = "senoshy";
      user.email = "riu@wiredbeing.com";
      init.defaultBranch = "master";
      url."https://github.com/".insteadOf = [
        "gh:"
        "github:"
      ];
    };
  };

  home.packages = with pkgs; [
    piper
    kdePackages.okular
    burpsuite
    fastfetch
    onlyoffice-desktopeditors
    proton-vpn
    bitwarden-desktop
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    yazi
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

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
