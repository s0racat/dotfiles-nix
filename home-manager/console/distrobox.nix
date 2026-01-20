{
  xdg.configFile."distrobox/distrobox.conf".text = ''
    container_user_custom_home="$HOME/distrobox"
    container_manager="podman"
    container_image_default="quay.io/toolbx/arch-toolbox:latest"
    container_name_default="arch"
  '';
  systemd.user.services.distrobox-upgrade= {
    Unit.Description = "distrobox-upgrade";
    Service = {
      ExecStart = "distrobox-upgrade --all";
      Type = "simple";
      StandardOutput = "null";
    };
  };

  systemd.user.timers.distrobox-upgrade= {
    Unit.Description = "distrobox-update";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
      OnBootSec="1h";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
