{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    fzf
    jq
    btop
    duf
    brightnessctl
    networkmanager
    swaynotificationcenter
    thunar
    waybar
  ];
}
