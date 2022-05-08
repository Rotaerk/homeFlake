{ config, pkgs, ... }:

let
  kak-lsp = pkgs.kak-lsp.overrideAttrs (attrs: rec {
    name = "${attrs.pname}-${version}";
    version = "12.2.0";

    # generated with: nix-prefetch-github --nix kak-lsp kak-lsp --rev v<version>
    src = pkgs.fetchFromGitHub {
      owner = "kak-lsp";
      repo = "kak-lsp";
      rev = "ed1fb46a7ce0821e11ad96da31b12b917dbdb245";
      sha256 = "jeOeUsnZ45VCg2bqNHNVQ5DS9CFSrXGc7BjknqR7m6c=";
    };

    cargoDeps = attrs.cargoDeps.overrideAttrs (cdattrs: {
      name = "${name}-vendor.tar.gz";
      inherit src;
      outputHash = "sha256-tXFzYdB3vIIWaxUmDDQSLpYoWEA6MhVloY50+H52P14=";
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
