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
    # Intentionally minimal: interactive config lives in the NixOS module
    # (modules/system/shell). This only makes HM generate ~/.zshenv with
    # ZDOTDIR + session vars so HM-managed packages stay on PATH.
    #programs.zsh.enable = true;
    # The system /etc/zshrc already runs compinit.
    #programs.zsh.enableCompletion = false;
  };
}
