{pkgs, ...}: {
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
    opencode
    instaloader
  ];

  programs.vinegar = {
    enable = true;

    settings = {
      studio = {
        renderer = "DXVK";
        gamemode = true;
        discord_rpc = true;

        virtual_desktop = "1600x900";

        env.WINEFSYNC = "1";

        fflags.DFIntTaskSchedulerTargetFps = 60;
      };
    };
  };

  xdg.desktopEntries."org.vinegarhq.Vinegar" = {
    name = "Roblox Studio";
    genericName = "Studio";
    comment = "Run Roblox Studio on Linux";
    exec = "vinegar %u";
    icon = "org.vinegarhq.Vinegar.studio";
    terminal = false;
    categories = ["Development" "Game"];
    mimeType = [
      "application/x-roblox-place"
      "application/x-roblox-model"
      "x-scheme-handler/roblox-studio"
      "x-scheme-handler/roblox-studio-auth"
    ];
    actions.manage = {
      name = "Manage";
      exec = "vinegar manage";
    };
  };

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
