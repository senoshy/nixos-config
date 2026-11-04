{
  flake.modules = {
    system = {
      audio = import ./nixos/audio;
      bluetooth = import ./nixos/bluetooth;
      boot = import ./nixos/boot;
      browsers = import ./nixos/browsers;
      fileSystem = import ./nixos/fileSystem;
      fonts = import ./nixos/fonts;
      gaming = import ./nixos/gaming;
      nix = import ./nixos/nix;
      shell = import ./nixos/shell;
      virtualisation = import ./nixos/virtualisation;
      secrets = import ./nixos/secrets;
      sysdep = import ./nixos/sysdep;
    };

    home = {
      browsers = {
        firefox = import ./home/browsers/firefox;
        chromium = import ./home/browsers/chromium;
      };
      media = import ./home/media;
      dev = import ./home/dev;
      xdg = import ./home/xdg;
      kanshi = import ./home/kanshi;
      theme = import ./home/theme;
      hyprland = import ./home/hyprland;
      waybar = import ./home/waybar;
      rofi = import ./home/rofi;
      kitty = import ./home/kitty;
      gpg = import ./home/gpg;
      ssh = import ./home/ssh;
      utils = import ./home/utils;
      zsh = import ./home/zsh;
    };
  };
}
