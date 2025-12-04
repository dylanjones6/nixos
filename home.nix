{ config, lib, pkgs, nixvim, ... }:

{
  imports = [
    ./nvim.nix
  ];
  
  home.username = "dilly";
  home.homeDirectory = "/home/dilly";
  
  home.packages = with pkgs; [
    neofetch
    ripgrep
    cowsay
    nnn
    fzf
    fd
	nerd-fonts.comic-shanns-mono
  ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf";
      "x-scheme-handler/http" = "librewolf";
      "x-scheme-handler/https" = "librewolf";
      "x-scheme-handler/about" = "librewolf";
      "x-scheme-handler/unknown" = "librewolf";
    };
  };
  
  programs.librewolf = {
    # enable = true;
    #settings = {
    #};
    policies = {
      privacy.clearOnShutdown.history = false;
      privacy.clearOnShutdown.cookies = false;
      ExtensionSettings = {
        #"*".installation_mode = "blocked";
        # uBlockOrigin
        # "uBlock0@raymondhill.net" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        #   installation_mode = "force_installed";
        #   private_browsing = true;
        #   default_area = "navbar";
        # };
        # AdNauseam
        "adnauseam@rednoise.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/adnauseam/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "navbar";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "navbar";
        };
        # HTTPS Everywhere maybe later? discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
      };
    };
  };

  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
	  shell_integration = true;
	  shell = "fish";
	  dynamic_background_opacity = true;
	  enable_audio_bell = false;
	  font_family = "ComicShannsMono Nerd Font Mono";
	  font_size = 12;
	  color0 =  "#1c2023";
	  color1 =  "#c7ae95";
	  color2 =  "#95c7ae";
	  color3 =  "#aec795";
	  color4 =  "#ae95c7";
	  color5 =  "#c795ae";
	  color6 =  "#95aec7";
	  color7 =  "#c7ccd1";
	  color8 =  "#747c84";
	  color9 =  "#c7ae95";
	  color10 = "#95c7ae";
	  color11 = "#aec795";
	  color12 = "#ae95c7";
	  color13 = "#c795ae";
	  color14 = "#95aec7";
	  color15 = "#f3f4f5";
    };
  };

  programs.git = {
    enable = true;
    settings.user.name = "dilly";
    settings.user.email = "dylanjones6@protonmail.com";
    settings.init.defaultBranch = "main";
  };
  
  home.stateVersion = "25.05";
}
