{ self, ... }:
{
  imports = [
    ./zsh
    ./git.nix
    ./tmux
    ./neovim
    ./packages.nix
    ./aria2.nix
    ./bat.nix
    ./htop.nix
    "${self}/common/nix-settings.nix"
    "${self}/home-manager/common"
  ];
}
