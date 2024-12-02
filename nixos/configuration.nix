# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  stateVersion,
  config,
  ...
}:

{
  imports = [
    ./nix.nix
  ];
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    "ip" = "127.0.0.1";
    "bip" = "172.18.0.1/24";
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  systemd.services.libvirtd-default-network = {
    enable = config.virtualisation.libvirtd.enable;
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
      ExecStop = ''
        ${pkgs.libvirt}/bin/virsh net-destroy default
      '';
    };
    restartIfChanged = false;
  };

  # bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.udisks2 = {
    enable = true;
    settings = {
      "tcrypt.conf" = { };
    };
  };

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

  # systemd
  services.logind.powerKey = "suspend";
  services.journald.extraConfig = ''
    SystemMaxUse=50M
  '';

  services.tlp = {
    enable = true;
  };

  services.gvfs.enable = true;
  programs.kdeconnect.enable = true;
  programs.firefox = {
    enable = true;
    languagePacks = [ "ja" ];
    autoConfig = ''
      // Use LANG environment variable to choose locale
      // https://gitlab.archlinux.org/archlinux/packaging/packages/firefox/-/blob/72e20d2777ce1f68e57dbffbb16026be43411b82/PKGBUILD#L210-211
      pref("intl.locale.requested", "");
    '';
    policies = {
      ExtensionSettings = {
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "normal_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
        };
        "tridactyl.vim@cmcaine.co.uk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
    };
    nativeMessagingHosts.packages = with pkgs; [
      tridactyl-native
      keepassxc
    ];
  };
  programs.chromium = {
    enable = true;
    extensions = [
      # "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
      "omkfmpieigblcllmkgbflkikinpkodlk" # enhanced-h264ify
    ];
  };

  # networking
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.firewall = {
    enable = true;
  };
  services.syncthing.openDefaultPorts = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # ime
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-skk
        fcitx5-gtk
        libsForQt5.fcitx5-qt
      ];
      waylandFrontend = true;
    };
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  hardware.i2c.enable = true;
  programs.zsh.enable = true;

  # sway
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      foot # Recognize foot as a command.
      grim
      slurp
      wl-clipboard
      wofi-emoji
      swappy
      lxqt.lxqt-policykit
      playerctl
      ddcutil
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    killall
    sbctl
    chromium
    keepassxc
    lxqt.pcmanfm-qt
    lxqt.pavucontrol-qt
    winetricks # winetricks (all versions)
    wineWowPackages.waylandFull # native wayland support (unstable)
    vscode.fhs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = stateVersion; # Did you read the comment?

  programs.nix-ld = {
    enable = true;
  };
  nix.settings.trusted-users = [
    "@wheel"
  ];

}
