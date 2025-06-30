{ isNixOS, ... }:
{
  services.kdeconnect = {
    enable = isNixOS;
  };
}
