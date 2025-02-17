{
  config,
  pkgs,
  isNixOS,
  lib,
  ...
}:
{
  services.mako = {
    enable = true;
    package = lib.mkIf (!isNixOS) pkgs.emptyDirectory;

    defaultTimeout = 10000;
    font = "monospace 10";
    backgroundColor = "#2E3440";
    iconPath = with config.gtk.iconTheme; "${package}/share/icons/${name}";
    extraConfig = ''
      [urgency=low]
      border-color=#8FBCBB

      [urgency=normal]
      border-color=#81A1C1

      [urgency=critical]
      border-color=#BF616A
    '';
  };
}
