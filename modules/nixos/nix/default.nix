{lib, ...}: let
  inherit (lib) mkDefault;
  kb = 1024;
  mb = 1024 * kb;
  gb = 1024 * mb;
in {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = mkDefault false;
    trusted-users = mkDefault ["root" "@wheel"];
    min-free = mkDefault (2 * gb);
    max-free = mkDefault (10 * gb);
    max-jobs = mkDefault 2;
    cores = mkDefault 2;
  };

  nix.daemonCPUSchedPolicy = "batch";
  nix.daemonIOSchedClass = "idle";
  nix.daemonIOSchedPriority = 7;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = "weekly";
  };
}
