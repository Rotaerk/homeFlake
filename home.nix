{ nur }:
{ config, pkgs, ... }:

let
  pkgsLocal = {
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
  };
in
{
  nixpkgs = {
    config.allowUnfreePredicate = _: true;
    overlays = [ nur.overlay ];
  };

  home.packages =
    (with pkgs; [
      discord
      dmenu
      nix-prefetch-github
      shutter
    ]) ++
    (with pkgsLocal; [
      kak-lsp
    ]);

  xdg.configFile = {
    "kak-lsp/kak-lsp.toml".source = "${pkgsLocal.kak-lsp.src}/kak-lsp.toml";
  };

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };

    profileExtra = ''
      # disable Display Power Management Service
      xset -dpms
      setterm -blank 0 -powerdown 0

      # turn off black Screensaver
      xset s off
    '';
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    alacritty.enable = true;

    firefox = {
      enable = true;
      profiles.rotaerk = {
        id = 0;
        isDefault = true;
        settings = {
          # Widevine is needed to enable watching Amazon Prime.
          # Widevine depends on DRM support, which Firefox implements with EME.
          "media.eme.enabled" = true;
          "media.gmp-widevinecdm.enabled" = true;
          "media.gmp-widevinecdm.visible" = true;
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        sponsorblock
        ublock-origin
      ];
    };

    git = {
      enable = true;
      userName = "rotaerk";
      userEmail = "m.scott.stewart@gmail.com";
    };

    kakoune = {
      enable = true;
      extraConfig = builtins.readFile ./kakrc;
      plugins = map pkgs.kakouneUtils.buildKakounePluginFrom2Nix (import ./kakPlugins.nix pkgs);
    };

    xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmobarrc;
    };
  };
}
