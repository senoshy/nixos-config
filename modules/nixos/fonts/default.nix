{
  pkgs,
  lib,
  config,
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
      ultimate-oldschool-pc-font-pack
      dosega
      tamzen-ttf
      inconsolata
      kirsch
      monaspace
      nerd-fonts.jetbrains-mono
      nerd-fonts.terminess-ttf
      nerd-fonts.symbols-only
      symbola
      liberation_ttf
      plemoljp
      corefonts
      dejavu_fonts
      open-sans
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
