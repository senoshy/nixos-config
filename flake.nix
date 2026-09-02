{
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    lib = import ./lib {
      inherit inputs self;
    };

    modules = import ./modules;
  in {
    modules = modules.flake.modules;

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      amadeus = lib.mkNixosConfig {
        hostName = "amadeus";
        system = "x86_64-linux";
        extraModules = [];
      };
    };

    homeConfigurations = {
      "riu" = lib.mkHMConfig {
        homeName = "riu";
        system = "x86_64-linux";
        extraModules = [];
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "github:stdriu/nvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fabric = {
      url = "github:Fabric-Development/fabric";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:Iniox/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    qylock = {
      url = "github:Darkkal44/qylock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
