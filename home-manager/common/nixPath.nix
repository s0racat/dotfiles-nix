{ pkgs, ... }:
{
  nix.nixPath = [ "nixpkgs=${pkgs.path}" ];
}
