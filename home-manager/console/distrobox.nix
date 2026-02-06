{ pkgs,  ... }:
{
  xdg.configFile."distrobox/distrobox.conf".text = ''
    container_manager="podman"
    container_image_default="quay.io/toolbx/arch-toolbox:latest"
    container_name_default="arch"
    container_home_prefix="$HOME/distrobox"
  '';
  xdg.configFile = {
    "distrobox/arch.ini".text = ''
      [arch]
      image="quay.io/toolbx/arch-toolbox:latest"
      additional_flags="--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/run/dbus/system_bus_socket"
      additional_packages="vim pacman-contrib"
      exported_bins="/usr/bin/makepkg /usr/bin/updpkgsums"
    '';
    "distrobox/kali.ini".text = ''
      [kali]
      image="docker.io/kalilinux/kali-rolling:latest"
      additional_flags="--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/run/dbus/system_bus_socket"
      additional_packages="kali-linux-headless"
    '';
    "distrobox/blackarch.ini".text = ''
      [blackarch]
      image="docker.io/blackarchlinux/blackarch:latest"
      additional_flags="--env DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/host/run/dbus/system_bus_socket"
    '';
  };

  systemd.user.services.distrobox-upgrade = {
    Unit.Description = "distrobox-upgrade";
    Service = {
      ExecStart = "${pkgs.distrobox}/bin/distrobox-upgrade --all";
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
