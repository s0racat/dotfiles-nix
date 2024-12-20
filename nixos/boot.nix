_:
{
  # boot
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 15;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 3;
  boot.tmp.useTmpfs = true;
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [
    # fix tofu in systemd boot log
    "locale.LANG=en_US.UTF-8"
  ];
}
