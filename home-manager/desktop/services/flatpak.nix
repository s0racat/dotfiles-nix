{
  lib,
  isNixOS,
  pkgs,
  config,
  ...
}:

lib.mkIf (!isNixOS) {
  xdg.configFile."autostart/mintupdate.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Hidden=true
  '';
  home.file.".local/bin/flatpak-update" = {
    source = pkgs.writeShellScript "flatpak-update" ''
      sleep 20
      OUTPUT=$(flatpak update -y --noninteractive 2>&1)

      COUNT=$(echo "$OUTPUT" | grep -c "^Updating ")

      if [ "$COUNT" -gt 0 ]; then
        echo "$COUNT 個のアプリが更新されました"
        notify-send "📦 Flatpak Update" "$COUNT 個のアプリが更新されました"
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
