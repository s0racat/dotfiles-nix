{ lib, pkgs, ... }:
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
    sensibleOnTop = false;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.better-mouse-mode;
        extraConfig = "set -g @emulate-scroll-for-no-mouse-alternate-buffer 'on'";
      }
    ];
    extraConfig =
      let
        tmux_commands_with_legacy_scroll = "nano less more man git";
        bg2 = "#3B4252";
        bg1 = "default";
        default_fg = "#D8DEE9";
        session_fg = "#A3BE8C";
        session_selection_fg = "#3B4252";
        session_selection_bg = "#81A1C1";
        active_window_fg = "#88C0D0";
        active_pane_border = "#abb2bf";
      in
      lib.mkMerge [
        ''
          # theme
          set -g status-style "bg=default,fg=${default_fg}"
          set -g window-status-current-format "#[fg=${default_fg},bg=${bg2}] #I: #W "
          set -g window-status-last-style "fg=${default_fg},bg=default"
          set -g message-command-style "bg=default,fg=${default_fg}"
          set -g message-style "bg=default,fg=${default_fg}"
          set -g mode-style "bg=${session_selection_bg},fg=${session_selection_fg}"
          set -g pane-active-border-style "fg=${active_pane_border},bg=default"
          set -g pane-border-style "fg=brightblack,bg=default"
          set -g menu-selected-style "bg=${session_selection_bg},fg=${session_selection_fg}"
        ''
        (lib.mkBefore (builtins.readFile ./tmux.conf))

      ];
  };
}
