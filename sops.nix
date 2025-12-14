# inspo: https://saylesss88.github.io/installation/enc/sops-nix.html?search=
{config, lib, pkgs, inputs, ...}:
let
  home_root = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/dilly"
    else "/home/dilly";
in
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${home_root}/.config/sops/age/keys.txt";
    age.generateKey = true;
    secrets."openssh/github-t480" = {};
    secrets."hostId" = {};
    secrets."wifi/home/ssid" = {};
    secrets."wifi/home/psk" = {};
    secrets."openssh/github" = {};
  };
}
