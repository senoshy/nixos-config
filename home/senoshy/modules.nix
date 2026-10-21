{self, ...}: {
  imports = with self.modules.home; [
    browsers.firefox
    browsers.chromium
    xdg
    theme
    dev
    caelestia
    gpg
    ssh
    utils
    media
    hyprland
    kanshi
    kitty
    zsh
  ];

  home.theme.enable = true;
  home.xdg.enable = true;
  home.dev.enable = true;
  home.caelestia.enable = true;
  home.browsers.enable = true;
  home.browsers.chromium.enable = true;
  home.hyprland.enable = true;
  home.kanshi.enable = true;
  home.kitty.enable = true;
  home.media.enable = true;
  home.dev.vscodium.enable = true;
  home.zsh.enable = true;
}
