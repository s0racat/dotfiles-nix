{
  pkgs,
  config,
  lib,
  ...
}:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
