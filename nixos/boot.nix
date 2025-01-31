_: {
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

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # https://www.suse.com/ja-jp/support/kb/doc/?id=000017857
  boot.kernel.sysctl = {
    "vm.dirty_bytes" = 600 * 1024 * 1024;
    "vm.dirty_background_bytes" = 300 * 1024 * 1024;
  };
}
