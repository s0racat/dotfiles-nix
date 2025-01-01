{
  inputs,
  lib,
  pkgs,
  username,
  stateVersion,
  self,
  ...
}:
{
  imports = [
    "${self}/hardware/um690pro.nix"
    "${self}/nixos/misc.nix"
    "${self}/nixos/nix.nix"
    "${self}/nixos/programs/firefox.nix"
    "${self}/nixos/programs/chromium.nix"
    "${self}/nixos/boot.nix"
    "${self}/nixos/systemd.nix"
    "${self}/nixos/packages.nix"
    "${self}/nixos/networking.nix"
    "${self}/nixos/desktop/ime.nix"
    "${self}/nixos/desktop/sway.nix"
    "${self}/nixos/desktop/font.nix"
    "${self}/nixos/services/tlp.nix"
    "${self}/nixos/services/gvfs.nix"
    "${self}/nixos/services/udisks2.nix"
    "${self}/nixos/services/pipewire.nix"
    "${self}/nixos/services/bluetooth.nix"
    "${self}/nixos/virtualisation/docker.nix"
    "${self}/nixos/virtualisation/libvirtd.nix"
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # comment to disable lanzaboote
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

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
      "${self}/home-manager/desktop/firefox/enable-av1.nix"
    ];
    home.stateVersion = stateVersion; # Please read the comment before changing.
  };
}
