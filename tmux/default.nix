{ pkgs, lib, ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    aggressiveResize = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "c-s";
    terminal = "xterm-256color";
    extraConfig = (lib.readFile ./tmux.conf.extra);
    plugins = with pkgs.tmuxPlugins; [
      nord
    ];
  };
}