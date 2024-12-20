{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    killall
    sbctl
    chromium
    keepassxc
    lxqt.pcmanfm-qt
    lxqt.pavucontrol-qt
    winetricks # winetricks (all versions)
    wineWowPackages.waylandFull # native wayland support (unstable)
    vscode.fhs
    mbusb
    gparted
    exfatprogs
  ];
}
