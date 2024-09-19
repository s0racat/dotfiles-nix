{ pkgs, ... }:
{
  programs.tmux = {
    shell = "${pkgs.zsh}/bin/zsh";
  };
  home.file.".bashrc".text = builtins.readFile ./bashrc;
}
