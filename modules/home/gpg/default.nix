{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;

    pinentry.package = lib.mkDefault pkgs.pinentry-qt;

    defaultCacheTtl = lib.mkDefault 7200;
    maxCacheTtl = lib.mkDefault 28800;
  };
}
