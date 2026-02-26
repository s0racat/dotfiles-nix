{
  lib,
  isNixOS,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  nixosFlatpak = osConfig.services.flatpak.enable;
in
lib.mkIf (!isNixOS || nixosFlatpak) {
  xdg.configFile."autostart/mintupdate.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Hidden=true
  '';
  home.file.".local/bin/flatpak-update" = {
    source = pkgs.writeShellScript "flatpak-update" ''
      sleep 20

      flatpak update -y --noninteractive 2>&1

      notify-send "📦 Flatpak Update" "flatpakアプリが更新されました"
    '';
    executable = true;
  };
  xdg.configFile."autostart/flatpak-update.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Flatpak Update
    Exec=${config.home.homeDirectory}/.local/bin/flatpak-update
    X-GNOME-Autostart-enabled=true
  '';
}
