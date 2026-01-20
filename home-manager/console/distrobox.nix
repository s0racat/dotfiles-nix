{
  xdg.configFile."distrobox/distrobox.conf".text = ''
    container_manager="podman"
    container_image_default="quay.io/toolbx/arch-toolbox:latest"
    container_name_default="arch"
    container_home_prefix="$HOME/distrobox"
  '';
  systemd.user.services.distrobox-upgrade = {
    Unit.Description = "distrobox-upgrade";
    Service = {
      ExecStart = "distrobox-upgrade --all";
      Type = "simple";
      # StandardOutput = "null";
    };
  };

  systemd.user.timers.distrobox-upgrade = {
    Unit.Description = "distrobox-update";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
      OnBootSec = "1h";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
