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
    libsForQt5.qt5ct
    kdePackages.qt6ct
    winetricks # winetricks (all versions)
    wineWow64Packages.waylandFull # native wayland support (unstable)
    vscode-fhs
    mbusb
    gparted
    exfatprogs
    quickemu
    xfce4-terminal
    lxqt.lxqt-archiver
    lsof
  ];

}
