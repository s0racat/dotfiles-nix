_:
let
  envvar = {

    MOZ_DBUS_REMOTE = 1;
    MOZ_LEGACY_PROFILES = 1; # fix Profile Missing
  };
in
{
  home.sessionVariables = envvar;
  systemd.user.sessionVariables = envvar;

}
