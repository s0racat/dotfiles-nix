{ ... }:
{
  imports =
    let
      zshConfig = import ./zsh/default.nix;
      gitConfig = import ./git/default.nix;
      tmuxConfig = import ./tmux/default.nix;
      neovimConfig = import ./neovim/default.nix;
      packageConfig = import ./home.nix;
      miscConfig = import ./misc/default.nix;
      defaultHomeConfig = import ../default.nix;
    in
    [
      defaultHomeConfig
      packageConfig
      gitConfig
      zshConfig
      tmuxConfig
      neovimConfig
      miscConfig
    ];
}
