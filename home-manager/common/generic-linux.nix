{ isNixOS, ... }:
{
  targets.genericLinux.enable = !isNixOS;
}
