{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.kdeconnect = {
    enable = true;
  };
}
