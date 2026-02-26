{ pkgs, ... }:
{
  xdg.configFile."picom/picom.conf".source = ./picom.conf;
  xdg.configFile."autostart/picom.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Type=Application
    NoDisplay=false
    Name=picom
    GenericName=X compositor
    Comment=An X compositor
    Categories=Utility;
    Keywords=compositor;composite manager;window effects;transparency;opacity;
    TryExec=picom
    Exec=${pkgs.writeShellScript "picom" ''
      if [ -n "$XRDP_SESSION" ]; then
        picom --backend xrender;
      else
        picom;
      fi''}
    StartupNotify=false
    Terminal=false
    # Thanks to quequotion for providing this file!
    Icon=picom
  '';
}
