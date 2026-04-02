{
  pkgs,
  isNixOS,
  ...
}:
{
  services.swayosd.enable = isNixOS;
  services.swayosd.stylePath = "${pkgs.swayosd}/etc/xdg/swayosd/style.css";
}
