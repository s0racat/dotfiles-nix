{ lib, isNixOS, ... }:
{
  imports = [
    ./gnome-keyring.nix
    ./kdeconnect.nix
    ./syncthing.nix
    ./flatpak.nix
  ];
}
