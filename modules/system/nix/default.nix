{lib, ...}: let
  inherit (lib) mkDefault;
  kb = 1024;
  mb = 1024 * kb;
  gb = 1024 * mb;
in {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = mkDefault true;
    trusted-users = mkDefault ["root" "@wheel"];
    min-free = mkDefault (2 * gb);
    max-free = mkDefault (10 * gb);
    max-jobs = mkDefault 2;
    cores = mkDefault 2;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
