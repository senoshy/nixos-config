{
  pkgs,
  config,
  lib,
  ...
}: {
  services.network-manager-applet.enable = true;

  home.packages = with pkgs; [
    fzf
    jq
    btop
    duf
    brightnessctl
    thunar
  ];

  xfconf.settings.thunar = {
    "hidden-bookmarks" = [
      "file://${config.home.homeDirectory}/desktop"
      "recent:///"
    ];
    "last-view" = "ThunarIconView";
  };
}
