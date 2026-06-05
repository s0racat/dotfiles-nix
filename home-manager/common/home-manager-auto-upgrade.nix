{
  config,
  isNixOS,
  pkgs,
  ...
}:
{
  # https://github.com/nix-community/home-manager/pull/8353
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
