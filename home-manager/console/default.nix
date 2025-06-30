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
    "${self}/nixos/nix.nix"
    "${self}/home-manager/common"
  ];
}
