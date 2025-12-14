{ self, ... }:
{
  imports = [
    # import base console config
    "${self}/home-manager/console"
    ./sway
    ./theme
    ./services
    ./fcitx5
    ./gnome
    ./cinnamon
    ./apps
    ./env
  ];
}
