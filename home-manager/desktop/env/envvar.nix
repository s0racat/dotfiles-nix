{ config, lib, ... }:
let
  envvar = {

    MOZ_DBUS_REMOTE = 1;
    MOZ_LEGACY_PROFILES = 1; # fix Profile Missing
    TERMINAL = "alacritty";

  };
in
{
  home.sessionVariables = envvar;
  systemd.user.sessionVariables =
    (builtins.removeAttrs config.home.sessionVariables [ "NIX_PATH" ])
    // (lib.optionalAttrs (builtins.hasAttr "XCURSOR_PATH" config.home.sessionSearchVariables) {
      XCURSOR_PATH = builtins.concatStringsSep ":" config.home.sessionSearchVariables.XCURSOR_PATH;
    });

}
