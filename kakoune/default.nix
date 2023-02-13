{ config, pkgs, ... }:

{
  home.packages = [ pkgs.kak-lsp ];

  xdg.configFile."kak-lsp/kak-lsp.toml".source = "${pkgs.kak-lsp.src}/kak-lsp.toml";

  programs.kakoune = {
    enable = true;
    extraConfig = builtins.readFile ./kakrc;
    plugins = map pkgs.kakouneUtils.buildKakounePluginFrom2Nix (import ./plugins.nix pkgs);
  };
}
