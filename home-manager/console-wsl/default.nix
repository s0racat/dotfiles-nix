{ self, ... }:
{
  imports = [
    "${self}/home-manager/console"
    ./wsl.nix
    "${self}/nixos/nix.nix"
  ];
}
