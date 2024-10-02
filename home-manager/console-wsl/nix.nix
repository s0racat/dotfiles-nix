{ pkgs, ... }:
{
  nix.gc.frequency = "weekly";
  nix.package = pkgs.nix;
}
