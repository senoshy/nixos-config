{
  inputs,
  self,
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  pkgsFor = system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [(import "${self}/overlays" {inherit inputs self;})];
    };
in {
  mkNixosConfig = {
    hostName,
    extraModules ? [],
    system ? "x86_64-linux",
  }:
    nixosSystem {
      pkgs = pkgsFor system;
      specialArgs = {inherit inputs self;};
      modules = ["${self}/hosts/${hostName}/configuration.nix"] ++ extraModules;
    };

  mkHMConfig = {
    homeName,
    hostName ? "nixos",
    extraModules ? [],
    system ? "x86_64-linux",
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor system;
      extraSpecialArgs = {
        inherit inputs self system hostName;
      };
      modules = ["${self}/home/${homeName}/home.nix"] ++ extraModules;
    };
}
