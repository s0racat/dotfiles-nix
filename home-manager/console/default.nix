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
    ./fzf.nix
    ./gh.nix
    ./gpg-agent.nix
    ./lazygit.nix
    ./starship.nix
    ./zoxide.nix
    "${self}/common/nix-settings.nix"
    "${self}/home-manager/common"
  ];
}
