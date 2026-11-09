{
  inputs,
  pkgs,
  system,
  ...
}: let
  obsidianPlugins = inputs.obsidian-extensions.legacyPackages.${system}.obsidianPlugins;
in {
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

    # Register c-learn and install its community plugins declaratively.
    # Core settings stay plain files in the obsidian-vaults repo; only the
    # community plugin list and plugin directories are linked from Nix.
    vaults."c-learn" = {
      target = "obsidian-vaults/c-learn";
      settings.communityPlugins = [
        obsidianPlugins.obsidian-kanban
        obsidianPlugins.templater-obsidian
        obsidianPlugins.dataview
        obsidianPlugins.quickadd
        obsidianPlugins.calendar
        obsidianPlugins.table-editor-obsidian
        obsidianPlugins.obsidian-git
      ];
    };
  };

  # The main obsidian-vaults vault is already registered in Obsidian under its
  # own id, so declaring it as an HM vault would add a duplicate obsidian.json
  # entry. Install Kanban into it directly instead.
  home.file = {
    "obsidian-vaults/.obsidian/community-plugins.json".text = builtins.toJSON ["obsidian-kanban"];
    "obsidian-vaults/.obsidian/plugins/obsidian-kanban" = {
      source = obsidianPlugins.obsidian-kanban;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
