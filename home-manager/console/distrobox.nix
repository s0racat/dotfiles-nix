{
  xdg.configFile."distrobox/distrobox.conf".text = ''
    container_manager="podman"
    container_image_default="quay.io/toolbx/arch-toolbox:latest"
    container_name_default="arch"
    container_home_prefix="$HOME/distrobox"
  '';
  xdg.configFile."distrobox/distrobox.ini".text = ''
    [arch]
    image="quay.io/toolbx/arch-toolbox:latest"
    additional_flags="--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/run/dbus/system_bus_socket"
    additional_packages="vim pacman-contrib"
    exported_bins="/usr/bin/makepkg /usr/bin/updpkgsums"

    [kali]
    image="docker.io/kalilinux/kali-rolling:latest"
    additional_packages="kali-linux-headless"
    additional_flags="--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/run/dbus/system_bus_socket"
  '';
  systemd.user.services.distrobox-upgrade = {
    Unit.Description = "distrobox-upgrade";
    Service = {
      Environment = "PATH=%h/.local/bin:/usr/local/bin:/usr/bin:/bin";
      ExecStart = "%h/.local/bin/distrobox-upgrade --all";
      Type = "simple";
      StandardOutput = "null";
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
