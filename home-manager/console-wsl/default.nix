{ self, ... }:
{
  imports = [
    "${self}/home-manager/console"
    ./wsl.nix
  ];
}
