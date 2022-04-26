{
  description = "My Nix Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #kakoune plugins
    smarttab-kak = {
      url = "github:andreyorst/smarttab.kak";
      flake = false;
    };
  };

  outputs = flakeInputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "rotaerk";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home.nix { inherit flakeInputs; };

        inherit system username;
        homeDirectory = "/home/${username}";

        stateVersion = "22.05";
      };
    };
}
