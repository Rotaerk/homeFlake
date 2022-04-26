{ flakeInputs }:
{ config, pkgs, ... }:
{
  home.packages = [ ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file =
  let
    kakAutoload = ".config/kak/autoload/";
  in {
    smarttab-kak = {
      source = flakeInputs.smarttab-kak;
      target = kakAutoload + "smarttab.kak";
    };
  };

  programs = {
    kakoune = {
      enable = true;
      extraConfig = builtins.readFile ./kakrc;
    };

    git = {
      enable = true;
      userName = "rotaerk";
      userEmail = "m.scott.stewart@gmail.com";
    };
  };
}
