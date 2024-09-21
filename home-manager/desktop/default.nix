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
    ./firefox.nix
    ./wm/sway.nix
    ./misc/mpv.nix
    ./theme
    ./daemon/ssh-agent.nix
    ./fcitx5
  ];
}
