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
          // {
            "media.av1.enabled" = false;
          };

      };
    };
  };
}
