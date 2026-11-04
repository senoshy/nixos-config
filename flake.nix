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
      anteiku = lib.mkNixosConfig {
        hostName = "anteiku";
        system = "x86_64-linux";
      };
    };

    homeConfigurations = {
      "senoshy" = lib.mkHMConfig {
        homeName = "senoshy";
        hostName = "anteiku";
        system = "x86_64-linux";
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

    nvim-config = {
      url = "github:senoshy/nvim-config";
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
