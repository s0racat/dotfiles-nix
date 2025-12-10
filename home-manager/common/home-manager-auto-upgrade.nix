{
  config,
  isNixOS,
  self,
  ...
}:
{
  disabledModules = [ "services/home-manager-auto-upgrade.nix" ];
  imports = [ "${self}/modules/home-manager-auto-upgrade.nix" ];
  services.home-manager.autoUpgrade = {
    enable = !isNixOS;
    useFlake = true;
    frequency = "weekly";
    flakeDir = "${config.home.homeDirectory}/dotfiles-nix";
  };
}
