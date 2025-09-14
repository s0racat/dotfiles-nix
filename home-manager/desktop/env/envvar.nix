{ config, ... }:
let
  envvar = {

    MOZ_DBUS_REMOTE = 1;
    MOZ_LEGACY_PROFILES = 1; # fix Profile Missing
    PATH = "${config.home.profileDirectory}/bin:$PATH";
  };
in
{
  home.sessionVariables = envvar;
  systemd.user.sessionVariables = builtins.removeAttrs config.home.sessionVariables ["NIX_PATH"];

}
