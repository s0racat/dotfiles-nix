{
  lib,
  inputs,
  ...
}:
{
  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  nix.registry.nixpkgs.flake = inputs.nixpkgs-unstable;
  nix.registry.home-manager.flake = inputs.home-manager;
  nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];
  xdg.dataFile = lib.mapAttrs' (name: value: {
    name = "nix/inputs/${name}";
    value = {
      source = value.outPath;
    };
  }) inputs;
}
