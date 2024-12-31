{ self, ... }:
{
  imports = [
    # import base console config
    "${self}/home-manager/console"
    ./xdg.nix
    ./envvar.nix
    ./firefox
    ./sway
    ./misc
    ./theme
    ./daemon
    ./fcitx5
    ./keepassxc
    ./libreoffice.nix
    ./pcmanfm-qt/pcmanfm-qt.nix
  ];
}
