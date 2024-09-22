{ inputs, ... }:
{
  imports = [
    ../hardware/um690pro.nix
    ../nixos/configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.users.alice = import ../home-manager/desktop;
  home-manager.backupFileExtension = "hmbak";
}
