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
    settings = {
      default-timeout = 10000;
      font = "monospace 10";
      background-color = "#2E3440";
      icon-path = with config.gtk.iconTheme; "${package}/share/icons/${name}";
      "urgency=low" = {
        border-color = "#8FBCBB";
      };

      "urgency=normal" = {
        border-color = "#81A1C1";
      };

      "urgency=critical" = {
        border-color = "#BF616A";
      };
    };
  };

}
