{ config, pkgs, nur, ... }:
{
  home = {
    username = "rotaerk";
    homeDirectory = "/home/rotaerk";
    stateVersion = "22.05";
  };

  nixpkgs = {
    config.allowUnfreePredicate = _: true;
    overlays = [ nur.overlay ];
  };

  imports = [
    ./fcitx5
    ./gpg
    ./kakoune
    ./xmobar
    ./xmonad
  ];

  home.packages = with pkgs; [
    bashmount
    binutils
    citrix_workspace
    discord
    dmenu
    element-desktop
    gcc
    gmp
    gnumake
    msbuild
    ncpamixer
    ncurses
    nix-prefetch-github
    pavucontrol
    spectacle
    trayer
    tree
    unzip
    xivlauncher
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

          # Remove annoying indicator that's shown when webcam or mic is in use via firefox.
          "privacy.webrtc.legacyGlobalIndicator" = false;
          "privacy.webrtc.hideGlobalIndicator" = true;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          sponsorblock
          ublock-origin
        ];
      };
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
