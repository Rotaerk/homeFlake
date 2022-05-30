{ nur }:
{ config, pkgs, ... }:
{
  nixpkgs = {
    config.allowUnfreePredicate = _: true;
    overlays = [ nur.overlay ];
  };

  imports = [
    ./gpg
    ./kakoune
    ./xmobar
    ./xmonad
  ];

  home.packages = with pkgs; [
    bashmount
    binutils
    discord
    dmenu
    gcc
    gmp
    gnumake
    ncpamixer
    ncurses
    nix-prefetch-github
    pavucontrol
    spectacle
    trayer
    tree
    unzip
    xsel
  ];

  xsession = {
    enable = true;

    profileExtra = ''
      # disable Display Power Management Service
      xset -dpms
      setterm -blank 0 -powerdown 0

      # turn off black Screensaver
      xset s off
    '';

    initExtra = ''
      trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --height 21 --transparent true --tint 0x000000 --alpha 0 &
    '';
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    alacritty.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

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

    password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "/run/media/rotaerk/A45B-3882/.password-store";
      };
    };
  };
}
