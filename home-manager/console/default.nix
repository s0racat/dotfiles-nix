{ self, ... }:
{
  imports = [
    ./zsh
    ./tmux
    ./neovim
    ./aria2.nix
    ./bat.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg-agent.nix
    ./htop.nix
    ./lazygit.nix
    ./packages.nix
    ./starship.nix
    ./zoxide.nix
    ./nix-index.nix
    "${self}/common/nix-settings.nix"
    "${self}/home-manager/common"
  ];
}
