{self, ...}: {
  imports = with self.modules.home; [
    browsers.firefox
    browsers.chromium
    xdg
    theme
    dev
    gpg
    ssh
    utils
    media
    hyprland
    waybar
    rofi
    kanshi
    kitty
    zsh
  ];

  home.theme.enable = true;
  home.xdg.enable = true;
  home.dev.enable = true;
  home.browsers.enable = true;
  home.browsers.chromium.enable = true;
  home.hyprland.enable = true;
  home.waybar.enable = true;
  home.rofi.enable = true;
  home.kanshi.enable = true;
  home.kitty.enable = true;
  home.media.enable = true;
  home.dev.vscodium.enable = true;
  home.zsh.enable = true;
}
