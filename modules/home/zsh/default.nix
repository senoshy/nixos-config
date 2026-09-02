{
  lib,
  config,
  ...
}: let
  cfg = config.home.zsh;
in {
  options.home.zsh = {
    enable = lib.mkEnableOption "enable zsh env plumbing (dotDir, session vars)";
  };

  config = lib.mkIf cfg.enable {
    home.file.".zshrc".source = ./zshrc;
  };
}
