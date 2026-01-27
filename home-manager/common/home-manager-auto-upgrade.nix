{
  config,
  isNixOS,
  self,
  pkgs,
  ...
}:
{
  # https://github.com/nix-community/home-manager/pull/8353
  disabledModules = [ "services/home-manager-auto-upgrade.nix" ];
  imports = [ "${self}/modules/home-manager-auto-upgrade.nix" ];
  services.home-manager.autoUpgrade = {
    enable = !isNixOS;
    useFlake = true;
    flags = [
      "-b"
      "hmbak"
    ];
    preSwitchCommands = [ "${pkgs.gitMinimal}/bin/git pull" ];
    frequency = "weekly";
    flakeDir = "${config.home.homeDirectory}/dotfiles-nix";
  };
}
