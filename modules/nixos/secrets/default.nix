{
  inputs,
  self,
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.secrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  options.system.secrets = {
    enable = lib.mkEnableOption "enable secrets module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.sops];

    sops = {
      defaultSopsFile = "${self}/secrets/secrets.yaml";
      age.keyFile = "/var/lib/sops-nix/key.txt";
    };
  };
}
