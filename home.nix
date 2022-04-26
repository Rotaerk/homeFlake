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

    git =
      let
        gitPkg = pkgs.git.override { withLibsecret = true; };
      in {
        enable = true;
        userName = "rotaerk";
        userEmail = "m.scott.stewart@gmail.com";
        package = gitPkg;
        extraConfig.credential.helper = "${gitPkg}/bin/git-credential-libsecret";
      };
  };
}
