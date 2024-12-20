{ self, ... }:
{
  imports = [
    ./zsh
    ./git.nix
    ./tmux
    ./neovim
    ./packages.nix
    ./misc
    "${self}/nixos/nix.nix"
    "${self}/home-manager/common"
  ];
}
