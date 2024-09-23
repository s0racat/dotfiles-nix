{ ... }:
{
  disabledModules = [
    "programs/zsh.nix"
  ];
  imports = [
    # override home-manager zsh module
    ../../modules/home-manager/zsh.nix
    ../console
    ./wsl.nix
    ./nix.nix
    ./windows/firefox.nix
    ./windows/wt.nix
    ./windows/fancywm.nix
    ./windows/keepassxc.nix
  ];
}
