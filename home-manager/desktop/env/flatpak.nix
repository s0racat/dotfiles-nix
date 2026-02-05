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

      APPS=$(echo "$OUTPUT" \
        | grep "^Updating " \
        | sed 's|^Updating app/||; s|/.*||')

      COUNT=$(echo "$APPS" | grep -c .)

      if [ "$COUNT" -gt 0 ]; then
        NAMES=""
        for app in $APPS; do
          NAMES="$NAMES\n・$app"
        done

        notify-send "📦 Flatpak Update" "$COUNT 個のアプリが更新されました$NAMES"
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
