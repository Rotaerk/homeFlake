{ config, pkgs, ... }:
let
  kak-lsp = pkgs.callPackage ./kak-lsp.nix { inherit (pkgs.darwin.apple_sdk.frameworks) Security SystemConfiguration; };
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
