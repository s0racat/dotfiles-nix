{
  pkgs,
  username,
  self,
  ...
}:
let
  nixosDir = "${self}/nixos";
  serviceModules = [

    "${nixosDir}/services/bluetooth.nix"
    "${nixosDir}/services/gvfs.nix"
    "${nixosDir}/services/pipewire.nix"
    "${nixosDir}/services/tlp.nix"
    "${nixosDir}/services/udisks2.nix"

  ];
  commonModules = [
    "${self}/common/nix-settings.nix"
    "${nixosDir}/boot.nix"
    "${nixosDir}/locale.nix"
    "${nixosDir}/networking.nix"
    "${nixosDir}/nix-settings.nix"
    "${nixosDir}/packages.nix"
    "${nixosDir}/systemd.nix"
  ];
  desktopModules = [

    "${nixosDir}/desktop/ime.nix"
    "${nixosDir}/desktop/sway.nix"
    "${nixosDir}/apps/ddcutil.nix"
    "${nixosDir}/apps/firefox.nix"
    "${nixosDir}/apps/misc.nix"
    "${nixosDir}/apps/nix-ld.nix"

  ];
  virtModules = [

    "${nixosDir}/virtualisation/docker.nix"
    "${nixosDir}/virtualisation/libvirtd.nix"
  ];
in
{
  imports = [
    "${self}/nixos/hardware/um690pro.nix"
    #inputs.lanzaboote.nixosModules.lanzaboote
  ]
  ++ commonModules
  ++ virtModules
  ++ desktopModules
  ++ serviceModules;

  # comment to disable lanzaboote
  # boot.loader.systemd-boot.enable = lib.mkForce false;
  #
  # boot.lanzaboote = {
  #   enable = true;
  #   pkiBundle = "/etc/secureboot";
  # };

  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    maxGenerations = 15;
  };

  system.stateVersion = "25.05"; # Did you read the comment?

  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "video"
      "i2c"
      "docker"
      "libvirtd"
    ];
    packages = with pkgs; [ ];
    initialPassword = "123456";
  };

  home-manager.users."${username}" = {
    imports = [
      "${self}/home-manager/desktop"
    ];
    home.stateVersion = "25.05"; # Please read the comment before changing.
  };
}
