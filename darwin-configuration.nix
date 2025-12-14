{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    tree
    tmux
    cbonsai
    mosh
    direnv
    sops
    age
    curl
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  users.users.dilly.home = "/Users/dilly";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
