{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.sysdep;
in {
  options.system.sysdep = {
    enable = lib.mkEnableOption "health care";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      eza
      curl
      wget
      unzip
      ripgrep
      zoxide
    ];
  };
}
