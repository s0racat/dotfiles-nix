
{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.firefox = {
    enable = true;
    package = null;
    profiles = {
      default = {
        settings = {
          "media.ffmpeg.vaapi.enabled" = true;
        };

        bookmarks = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://wiki.nixos.org/";
              }
              {
                name = "unofficial wiki";
                url = "https://nixos.wiki/";
              }
              {
                name = "Home Manager Option Search";
                url = "https://home-manager-options.extranix.com/";
              }
              {
                name = "NixOS Search";
                url = "https://search.nixos.org/packages";
              }
            ];
          }
        ];
      };
    };
  };
}
