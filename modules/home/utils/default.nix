{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
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
