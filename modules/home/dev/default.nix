{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.home.dev;
in {
  imports = [
    ./nvim-theme.nix
    ./vscodium.nix
    ./zed.nix
  ];

  options.home.dev = {
    enable = lib.mkEnableOption "enable dev module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      gdb
      gnumake
      inputs.nvim-config.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
