{
  inputs,
  lib,
  pkgs,
  username,
  stateVersion,
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
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "video"
      "i2c"
      "docker"
      "libvirtd"
    ];
    packages = with pkgs; [ ];
    initialPassword = "123456";
  };

  home-manager.users."${username}" = {
    imports = [
      ../home-manager/desktop
      ../home-manager/desktop/firefox/enable-av1.nix
    ];
    home.stateVersion = stateVersion; # Please read the comment before changing.
  };
}
