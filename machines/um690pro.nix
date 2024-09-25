{ inputs, lib, ... }:
{
  imports = [
    ../nixos/hardware/um690pro.nix
    ../nixos/configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  home-manager.users.alice = import ../home-manager/desktop;
  home-manager.backupFileExtension = "hmbak";
}
