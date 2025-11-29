{ config, pkgs, ... }:

{
  #imports = [
  #  ./nvim.nix
  #];
  
  home.username = "dilly";
  home.homeDirectory = "/home/dilly";
  
  home.packages = with pkgs; [
    neofetch
    ripgrep
    cowsay
    nnn
    fzf
    fd
  ];

  #home.backupFileExtension = "backup";

  #programs.bash = {
  #initExtra = ''
  #  if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
  #  then
  #    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
  #    exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
  #  fi
  #  '';
  #};

  #programs.fish = {
  #  enable = true;
  #  interactiveShellInit = ''
  #    set fish_greeting 
  #  '';
  #};

  programs.nushell = {
    enable = true;
    shellAliases = {
      nixup = "sudo nixos-rebuild switch";
      connect-vpn = "sudo systemctl start openvpn-homeVPN.service";
      disconnect-vpn = "sudo systemctl stop openvpn-homeVPN.service";
      zj = "zellij";
    };
    extraConfig = ''
    $env.config.buffer_editor = "nvim"
    $env.EDITOR = "nvim"
    '';
  };
  
  programs.librewolf = {
    enable = true;
    #settings = {
    #};
    policies = {
      privacy.clearOnShutdown.history = false;
      privacy.clearOnShutdown.cookies = false;
      ExtensionSettings = {
        #"*".installation_mode = "blocked";
        # uBlockOrigin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
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

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  programs.git = {
    enable = true;
    userName = "dilly";
    userEmail = "dylanjones6@protonmail.com";
    extraConfig.init.defaultBranch = "main";
  };
  
  home.stateVersion = "25.05";
}
