{
  lib,
  inputs,
  config,
  ...
}:
{
  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  nix.registry.nixpkgs.flake = inputs.nixpkgs-unstable;
  nix.nixPath = [ "nixpkgs=${config.xdg.dataHome}/nix/inputs/nixpkgs-unstable" ];
  xdg.dataFile = lib.mapAttrs' (name: value: {
    name = "nix/inputs/${name}";
    value = {
      source = value.outPath;
    };
  }) inputs;
}
