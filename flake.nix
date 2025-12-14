{
  description = "A much less simple NixOS flake :)";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url =  "github:nix-community/disko/master";
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    #TODO maybe put home-manager stuff here from: nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, home-manager, sops-nix, disko, ... }@inputs: {
    nixosConfigurations.nixos-t480 = nixpkgs-unstable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hosts/t480/default.nix
        ./hosts/t480/hardware-configuration.nix
        ./hosts/t480/disk-config-t480.nix
        ./sops.nix

        sops-nix.nixosModules.sops
        disko.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.dilly = import ./home.nix;
        }
      ];
    };
    nixosConfigurations.nixos-server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hosts/server/default.nix
        ./hosts/server/hardware-configuration.nix
        ./hosts/server/disk-config-server.nix
        ./sops.nix

        sops-nix.nixosModules.sops
        disko.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.dilly = import ./home.nix;
        }
      ];
    };
    darwinConfigurations."mbp" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; };
      modules = [
        ./darwin-configuration.nix
        ./hosts/mbp/default.nix
        # ./hosts/server/hardware-configuration.nix
        # ./hosts/server/disk-config-server.nix
        ./sops.nix

        sops-nix.darwinModules.sops
        # disko.nixosModules.default

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.dilly = import ./home.nix;
        }
      ];
    };
  };
}
