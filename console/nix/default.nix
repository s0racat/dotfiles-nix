{ pkgs, ... }:
{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nixpkgs.overlays = [
    (import ../../overlay/skk-dicts/package.nix)
  ];
}
