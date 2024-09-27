{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./base-config.nix
    ./enable-vaapi.nix
    ./nativeMessage.nix
  ];
}
