{ pkgs, ... }:
{
  # sway
  services.gnome.gnome-keyring.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      foot # Recognize foot as a command.
      grim
      slurp
      wl-clipboard
      wofi-emoji
      swappy
      lxqt.lxqt-policykit
      playerctl
      ddcutil
    ];
  };
}
