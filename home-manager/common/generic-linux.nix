{ pkgs, isNixOS, ... }:
{
  targets.genericLinux.enable = !isNixOS;
  targets.genericLinux.gpu.packages = pkgs.stable;
}
