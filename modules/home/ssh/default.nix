{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      identityFile = "/run/secrets/ssh_private_key";
      identitiesOnly = true;
    };
  };
}
