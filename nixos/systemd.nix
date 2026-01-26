{
  # systemd
  services.logind.settings.Login.HandlePowerKey = "suspend";
  services.journald.extraConfig = ''
    SystemMaxUse=50M
  '';
  systemd.settings.Manager = { DefaultTimeoutStopSec = "10s"; };
  systemd.user.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
