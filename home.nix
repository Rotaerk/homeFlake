{ config, pkgs, ... }:

let
  kak-lsp = pkgs.kak-lsp.overrideAttrs (attrs: rec {
    name = "${attrs.pname}-${version}";
    version = "12.2.0";

    # generated with: nix-prefetch-github --nix kak-lsp kak-lsp --rev v<version>
    src = pkgs.fetchFromGitHub {
      owner = "kak-lsp";
      repo = "kak-lsp";
      rev = "v${version}";
      sha256 = "Il3eF9bVrAaJkTDPB1DzEjROnJxIAnnk27qdT9qsp1k=";
    };

    cargoDeps = attrs.cargoDeps.overrideAttrs (cdattrs: {
      name = "${name}-vendor.tar.gz";
      inherit src;
      # Use this to obtain the hash after changing the revision.
      outputHash = "sha256-wRjPjCKsvqnJkybNVAdVMgBA9RaviFyCJPv3D5hipSs=";
    });
  });
in
{
  home = {
    packages = [
      pkgs.nix-prefetch-github
      kak-lsp
    ];

    file = {
      ".config/kak-lsp/kak-lsp.toml".source = "${kak-lsp.src}/kak-lsp.toml";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    kakoune = {
      enable = true;
      extraConfig = builtins.readFile ./kakrc;
      plugins = map pkgs.kakouneUtils.buildKakounePluginFrom2Nix (import ./kakPlugins.nix pkgs);
    };

    git = {
      enable = true;
      userName = "rotaerk";
      userEmail = "m.scott.stewart@gmail.com";
    };
  };
}
