{ self, ... }:
{
  imports = [
    ./zsh
    ./git.nix
    ./tmux
    ./neovim
    ./package.nix
    ./misc
    "${self}/nixos/nix.nix"
    "${self}/home-manager/common"
  ];
}
