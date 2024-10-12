{
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../nixos/hardware/um690pro.nix
    ../nixos/configuration.nix
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
  networking.hostName = "um690pro";
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "i2c"
      "docker"
      "libvirtd"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
    initialPassword = "123456";
  };

  home-manager.users."${username}" =
    { ... }:
    {
      imports = [
        ../home-manager/desktop
        ../home-manager/desktop/firefox/enable-av1.nix
      ];
      home.stateVersion = "24.05"; # Please read the comment before changing.
    };
}
