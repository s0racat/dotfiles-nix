{ config, pkgs, ... }:
{
  # download and mount https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
  # execute .\virtio-win-guest-tools.exe
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      swtpm.enable = true;
      runAsRoot = true;
    };
  };
  programs.virt-manager.enable = true;
  systemd.services.libvirtd-default-network = {
    inherit (config.virtualisation.libvirtd) enable;
    description = "libvirt default network autostart";
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = ''
        ${pkgs.libvirt}/bin/virsh net-start default
      '';
    };
    restartIfChanged = false;
  };
  # enable spice-vdagentd in guest(not host)
  # services.spice-vdagentd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
