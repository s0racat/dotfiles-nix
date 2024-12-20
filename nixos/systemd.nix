{
  # systemd
  services.logind.powerKey = "suspend";
  services.journald.extraConfig = ''
    SystemMaxUse=50M
  '';
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
