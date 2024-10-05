{ ... }:
{
  imports = [
    ./zsh
    ./git.nix
    ./tmux
    ./neovim
    ./package.nix
    ./misc
    ../home.nix
  ];
}
