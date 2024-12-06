{
  inputs,
  lib,
  pkgs,
  username,
  stateVersion,
  self,
  ...
}:
{
  imports = [
    "${self}/nixos/hardware/um690pro.nix"
    "${self}/nixos/configuration.nix"
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
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
      "${self}/home-manager/desktop"
      "${self}/home-manager/desktop/firefox/enable-av1.nix"
    ];
    home.stateVersion = stateVersion; # Please read the comment before changing.
  };
}
