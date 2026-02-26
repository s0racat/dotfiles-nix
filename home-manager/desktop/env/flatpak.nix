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

      OUTPUT=$(flatpak update -y --noninteractive 2>&1)
      if echo "$OUTPUT" | grep -q "Nothing to do"; then
        exit 0
      else
        notify-send "📦 Flatpak Update" "flatpakアプリが更新されました"
      fi
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
