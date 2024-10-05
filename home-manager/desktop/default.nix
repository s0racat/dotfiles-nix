{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # import base console config
    ../console
    ./xdg.nix
    ./envvar.nix
    ./firefox
    ./wm/sway.nix
    ./misc
    ./theme
    ./daemon
    ./fcitx5
    ./keepassxc
  ];
}
