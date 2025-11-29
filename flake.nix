{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # agenix.url = "github:ryantm/agenix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url =  "github:nix-community/disko/master";
    #disko = {
    #  url = "github:nix-community/disko/master";
    #  inputs.nixpkgs.follows = "nixpkgs-unstable";
    #};

    #"${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    #ssh-keys = {                      # idk what the fuck i'm doing
    #  url = "./.ssh/authorized_keys";
    #  flake = false;
    #};

    #TODO maybe put home-manager stuff here from: nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, home-manager, sops-nix, disko, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos-t480 = nixpkgs-unstable.lib.nixosSystem {
    #nixosConfigurations.nixos-t480 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./hosts/t480/default.nix
        ./hosts/t480/hardware-configuration.nix
        ./hosts/t480/disk-config-t480.nix

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

	#agenix.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.dilly = import ./home.nix;
        }
      ];
    };
  };
}
