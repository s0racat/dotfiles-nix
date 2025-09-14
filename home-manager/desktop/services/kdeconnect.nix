# apt: require kdeconnect
{ isNixOS, ... }:
{
  services.kdeconnect = {
    enable = isNixOS;
  };
}
