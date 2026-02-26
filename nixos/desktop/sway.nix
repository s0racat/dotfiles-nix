{ pkgs, ... }:
{
  # sway
  services.gnome.gnome-keyring.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export QT_QPA_PLATFORMTHEME=qt5ct
    '';
    extraPackages = with pkgs; [
      grim
      slurp
      wl-clipboard
      swappy
      lxqt.lxqt-policykit
      playerctl
    ];
  };
}
