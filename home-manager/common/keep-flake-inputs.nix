{ lib, inputs, ... }:
{
  xdg.dataFile = (
    lib.mapAttrs' (name: value: {
      name = "nix/inputs/${name}";
      value = {
        source = value.outPath;
      };
    }) inputs
  );
}
