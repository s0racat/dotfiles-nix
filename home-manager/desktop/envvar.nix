{ config, ... }:
{
  home.sessionVariables = {
    KPXC_CONFIG_LOCAL = "${config.xdg.configHome}/keepassxc/keepassxc.ini";
    MOZ_DBUS_REMOTE = 1;
  };
}
