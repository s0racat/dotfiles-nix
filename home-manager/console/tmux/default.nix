{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    aggressiveResize = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "c-s";
    terminal = "tmux-256color";
    historyLimit = 999999999;
    extraConfig = builtins.readFile ./tmux.conf.extra;
    plugins = with pkgs.tmuxPlugins; [ nord ];
  };
}
