{
  description = "My Nix Home Manager configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
    let
      system = "x86_64-linux";
      username = "rotaerk";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home.nix { inherit nur; };

        inherit system username;
        homeDirectory = "/home/${username}";

        stateVersion = "22.05";
      };
    };
}
