{ config, pkgs, ... }:

{
  home.packages = [ ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {

    kakoune = {
      enable = true;
      extraConfig = builtins.readFile ./kakrc;
    };

    git = {
      enable = true;
      userName = "rotaerk";
      userEmail = "m.scott.stewart@gmail.com";
      extraConfig.credential.helper = "store";
    };
  };
}
