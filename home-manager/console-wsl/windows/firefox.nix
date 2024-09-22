{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
  ../../desktop/firefox/base-config.nix
    ../../desktop/firefox/disable-av1.nix
  ];
  programs.firefox = {
    enable = true;
    package = null;
    profiles = {
      default = {
        settings = {
          "font.name.monospace.ja" = "Noto Sans CJK JP";
          "font.name.sans-serif.ja" = "Noto Sans CJK JP";
          "font.name.serif.ja" = "Noto Serif CJK JP";
        };
	userContent = builtins.readFile ./userContent.css;
      };
    };
  };
}
