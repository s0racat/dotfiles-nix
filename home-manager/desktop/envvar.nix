{ config, ... }:
{
  home.sessionVariables = {
    KPXC_CONFIG_LOCAL = "${config.xdg.configHome}/keepassxc/keepassxc.ini";
    MOZ_DBUS_REMOTE = 1;
    MOZ_LEGACY_PROFILES = 1; # fix Profile Missing
  };
  systemd.user.sessionVariables = {

    MOZ_LEGACY_PROFILES = 1; # fix Profile Missing
  };
}
