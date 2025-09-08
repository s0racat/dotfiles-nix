{ pkgs, ... }:
let
  theme = "nord";
in
{
  programs.alacritty = {
    enable = true;
    package = null;
    settings = {
      general.import = [ "${pkgs.alacritty-theme}/share/alacritty-theme/${theme}.toml" ];
      cursor.style = {
        blinking = "Always";
        shape = "Block";
      };

      env = {
        TERM = "tmux-256color";
      };

      font = {
        size = 11;
        bold.family = "monospace";
        bold_italic.family = "monospace";
        italic.family = "monospace";
        normal.family = "monospace";
      };

      keyboard.bindings = [
        {
          action = "Paste";
          key = "Paste";
        }
        {
          action = "Copy";
          key = "Copy";
        }
        {
          action = "ClearLogNotice";
          key = "L";
          mods = "Control";
        }
        {
          chars = "\\f";
          key = "L";
          mode = "~Vi|~Search";
          mods = "Control";
        }
        {
          action = "ScrollPageUp";
          key = "PageUp";
          mode = "~Alt";
          mods = "Shift";
        }
        {
          action = "ScrollPageDown";
          key = "PageDown";
          mode = "~Alt";
          mods = "Shift";
        }
        {
          action = "ScrollToTop";
          key = "Home";
          mode = "~Alt";
          mods = "Shift";
        }
        {
          action = "ScrollToBottom";
          key = "End";
          mode = "~Alt";
          mods = "Shift";
        }
        {
          action = "ScrollToBottom";
          key = "Space";
          mode = "Vi|~Search";
          mods = "Shift|Control";
        }
        {
          action = "ToggleViMode";
          key = "Space";
          mode = "~Search";
          mods = "Shift|Control";
        }
        {
          action = "ClearSelection";
          key = "Escape";
          mode = "Vi|~Search";
        }
        {
          action = "ScrollToBottom";
          key = "I";
          mode = "Vi|~Search";
        }
        {
          action = "ToggleViMode";
          key = "I";
          mode = "Vi|~Search";
        }
        {
          action = "ToggleViMode";
          key = "C";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "ScrollLineUp";
          key = "Y";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "ScrollLineDown";
          key = "E";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "ScrollToTop";
          key = "G";
          mode = "Vi|~Search";
        }
        {
          action = "ScrollToBottom";
          key = "G";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "ScrollPageUp";
          key = "B";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "ScrollPageDown";
          key = "F";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "ScrollHalfPageUp";
          key = "U";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "ScrollHalfPageDown";
          key = "D";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "Copy";
          key = "Y";
          mode = "Vi|~Search";
        }
        {
          action = "ClearSelection";
          key = "Y";
          mode = "Vi|~Search";
        }
        {
          action = "ClearSelection";
          key = "Copy";
          mode = "Vi|~Search";
        }
        {
          action = "ToggleNormalSelection";
          key = "V";
          mode = "Vi|~Search";
        }
        {
          action = "ToggleLineSelection";
          key = "V";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "ToggleBlockSelection";
          key = "V";
          mode = "Vi|~Search";
          mods = "Control";
        }
        {
          action = "ToggleSemanticSelection";
          key = "V";
          mode = "Vi|~Search";
          mods = "Alt";
        }
        {
          action = "Open";
          key = "Return";
          mode = "Vi|~Search";
        }
        {
          action = "Up";
          key = "K";
          mode = "Vi|~Search";
        }
        {
          action = "Down";
          key = "J";
          mode = "Vi|~Search";
        }
        {
          action = "Left";
          key = "H";
          mode = "Vi|~Search";
        }
        {
          action = "Right";
          key = "L";
          mode = "Vi|~Search";
        }
        {
          action = "Up";
          key = "Up";
          mode = "Vi|~Search";
        }
        {
          action = "Down";
          key = "Down";
          mode = "Vi|~Search";
        }
        {
          action = "Left";
          key = "Left";
          mode = "Vi|~Search";
        }
        {
          action = "Right";
          key = "Right";
          mode = "Vi|~Search";
        }
        {
          action = "First";
          key = "Key0";
          mode = "Vi|~Search";
        }
        {
          action = "Last";
          key = "Key4";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "FirstOccupied";
          key = "Key6";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "High";
          key = "H";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "Middle";
          key = "M";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "Low";
          key = "L";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "SemanticLeft";
          key = "B";
          mode = "Vi|~Search";
        }
        {
          action = "SemanticRight";
          key = "W";
          mode = "Vi|~Search";
        }
        {
          action = "SemanticRightEnd";
          key = "E";
          mode = "Vi|~Search";
        }
        {
          action = "WordLeft";
          key = "B";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "WordRight";
          key = "W";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "WordRightEnd";
          key = "E";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "Bracket";
          key = "Key5";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "SearchForward";
          key = "Slash";
          mode = "Vi|~Search";
        }
        {
          action = "SearchBackward";
          key = "Slash";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "SearchNext";
          key = "N";
          mode = "Vi|~Search";
        }
        {
          action = "SearchPrevious";
          key = "N";
          mode = "Vi|~Search";
          mods = "Shift";
        }
        {
          action = "SearchConfirm";
          key = "Return";
          mode = "Search|Vi";
        }
        {
          action = "SearchCancel";
          key = "Escape";
          mode = "Search";
        }
        {
          action = "SearchCancel";
          key = "C";
          mode = "Search";
          mods = "Control";
        }
        {
          action = "SearchClear";
          key = "U";
          mode = "Search";
          mods = "Control";
        }
        {
          action = "SearchDeleteWord";
          key = "W";
          mode = "Search";
          mods = "Control";
        }
        {
          action = "SearchHistoryPrevious";
          key = "P";
          mode = "Search";
          mods = "Control";
        }
        {
          action = "SearchHistoryNext";
          key = "N";
          mode = "Search";
          mods = "Control";
        }
        {
          action = "SearchHistoryPrevious";
          key = "Up";
          mode = "Search";
        }
        {
          action = "SearchHistoryNext";
          key = "Down";
          mode = "Search";
        }
        {
          action = "SearchFocusNext";
          key = "Return";
          mode = "Search|~Vi";
        }
        {
          action = "SearchFocusPrevious";
          key = "Return";
          mode = "Search|~Vi";
          mods = "Shift";
        }
        {
          action = "Paste";
          key = "V";
          mode = "~Vi";
          mods = "Control|Shift";
        }
        {
          action = "Copy";
          key = "C";
          mods = "Control|Shift";
        }
        {
          action = "SearchForward";
          key = "F";
          mode = "~Search";
          mods = "Control|Shift";
        }
        {
          action = "SearchBackward";
          key = "B";
          mode = "~Search";
          mods = "Control|Shift";
        }
        {
          action = "ClearSelection";
          key = "C";
          mode = "Vi|~Search";
          mods = "Control|Shift";
        }
        {
          action = "PasteSelection";
          key = "Insert";
          mods = "Shift";
        }
        {
          action = "ResetFontSize";
          key = "Key0";
          mods = "Control";
        }
        {
          action = "IncreaseFontSize";
          key = "Equals";
          mods = "Control";
        }
        {
          action = "IncreaseFontSize";
          key = "Plus";
          mods = "Control";
        }
        {
          action = "IncreaseFontSize";
          key = "NumpadAdd";
          mods = "Control";
        }
        {
          action = "DecreaseFontSize";
          key = "Minus";
          mods = "Control";
        }
        {
          action = "DecreaseFontSize";
          key = "NumpadSubtract";
          mods = "Control";
        }
      ];

      shell = {
        program = "/usr/bin/zsh";
        args = [
          "--login"
          "-c"
          "tmux attach || tmux"
        ];
      };

      window.opacity = 1.0;

    };
  };
}
