{ ... }:
{
  disabledModules = [ "programs/zsh.nix" ];
  imports = [
    # override home-manager zsh module
    ../../modules/home-manager/zsh.nix
    ../console
    ./wsl.nix
    ../../nixos/nix.nix
    ./nix.nix
  ];
}
