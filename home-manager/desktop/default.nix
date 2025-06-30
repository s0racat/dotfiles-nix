{ self, ... }:
{
  imports = [
    # import base console config
    "${self}/home-manager/console"
    ./xdg.nix
    ./envvar.nix
    ./firefox.nix
    ./sway
    ./mpv.nix
    ./theme
    ./services
    ./fcitx5
    ./keepassxc.nix
    ./pcmanfm-qt/pcmanfm-qt.nix
    ./alacritty.nix
  ];
}
