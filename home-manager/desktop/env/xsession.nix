# apt: require gnome-session
{
  xsession.enable = true;
  xsession.windowManager.command = ''
    export XDG_SESSION_TYPE=x11
    export GDK_BACKEND=x11
    exec gnome-session
  '';
}
