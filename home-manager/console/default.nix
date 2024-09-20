{ ... }:
{
  imports =
    let
      zshConfig = import ./zsh/default.nix;
      gitConfig = import ./git/default.nix;
      tmuxConfig = import ./tmux/default.nix;
      neovimConfig = import ./neovim/default.nix;
      homeConfig = import ./home.nix;
      miscConfig = import ./misc/default.nix;
      defaultHomeConfig = import ../default.nix;
    in
    [
      defaultHomeConfig
      homeConfig
      gitConfig
      zshConfig
      tmuxConfig
      neovimConfig
      miscConfig
    ];
}
