{
  pkgs,
  lib,
  config,
  isNixOS,
  ...
}:
{
  services.swayosd.enable = true;
  services.swayosd.stylePath = "${pkgs.swayosd}/etc/xdg/swayosd/style.css";
}
