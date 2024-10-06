{ ... }:
{
  home-manager.backupFileExtension = "hmbak";
  # use flake's nixpkgs settings.
  home-manager.useGlobalPkgs = true;
}
