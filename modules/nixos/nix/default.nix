{lib, ...}: let
  inherit (lib) mkAfter mkDefault;
  kb = 1024;
  mb = 1024 * kb;
  gb = 1024 * mb;
in {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = mkDefault false;
    # nixpkgs already defines trusted-users = [ "root" ], so mkDefault here is
    # silently dropped; append @wheel instead so members can pass cache options
    # to the daemon (needed for the hyprland.cachix.org substituter below).
    trusted-users = mkAfter ["@wheel"];
    min-free = mkDefault (2 * gb);
    max-free = mkDefault (10 * gb);
    max-jobs = mkDefault 2;
    cores = mkDefault 2;

    # Hyprland comes from the upstream flake (see overlays/default.nix), whose
    # CI pushes every build to cachix. Without this the compositor and its
    # newer aquamarine are compiled from source locally.
    extra-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
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
