{ config, ... }:
{
  home.sessionVariables = {
    MOZ_DBUS_REMOTE = 1;
    MOZ_LEGACY_PROFILES = 1; # fix Profile Missing
  };
  xsession.enable = true;
  xsession.windowManager.command = ''
    export XDG_SESSION_TYPE=x11
    export GDK_BACKEND=x11
    exec gnome-session
  '';

}
