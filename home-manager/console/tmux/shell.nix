{ pkgs, ... }:
{
  programs.tmux = {
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
