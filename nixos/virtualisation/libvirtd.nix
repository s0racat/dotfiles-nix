{ config, pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
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
}
