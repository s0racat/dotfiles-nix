{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.firefox = {
    profiles = {
      default = {
        settings =
          {
          }
          # Enable VAAPI
          // {
            "media.ffmpeg.vaapi.enabled" = true;
          };

      };
    };
  };
}
