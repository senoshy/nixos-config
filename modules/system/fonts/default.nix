{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.system.fonts;
in {
  options.system.fonts = {
    enable = lib.mkEnableOption "enable system fonts";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      sf-mono-liga-bin
      dosega
      tamzen-ttf
      inconsolata
      monaspace
      nerd-fonts.jetbrains-mono
      liberation_ttf
      plemoljp

      # dependencies
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      noto-fonts
      font-awesome
      material-symbols
      rubik
      roboto
      nerd-fonts.caskaydia-cove
    ];
  };
}
