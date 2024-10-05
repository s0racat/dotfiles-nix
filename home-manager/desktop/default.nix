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
    ./sway
    ./misc
    ./theme
    ./daemon
    ./fcitx5
    ./keepassxc
  ];
}
