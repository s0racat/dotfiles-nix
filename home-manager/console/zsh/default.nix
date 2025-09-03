{
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:
{
  programs.zsh = {
    enable = true;
    package = lib.mkIf (!isNixOS) pkgs.emptyDirectory;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    localVariables = {
      WORDCHARS = "*?_-.[]~=&;!#$%^(){}<>";
    };
    shellAliases = {
      gksu = "pkexec env WAYLAND_DISPLAY=$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY XDG_RUNTIME_DIR=/run/user/0 DISPLAY=$DISPLAY";
      npm = "pnpm";
      cz = "git cz";
      nix-shell = "nix-shell --command $(command -v zsh)";
      rm = "rip";
      lg = "lazygit";
      ll = "exa -F -alg --time-style=long-iso";
      ls = "exa -F --time-style=long-iso";
      l = "ls";
      la = "exa -F -a --time-style=long-iso";
      tree = "exa -T --time-style=long-iso";
      cp = "cp -v";
      mv = "mv -v";
      # rm = "rm -vi";
      mkdir = "mkdir -vp";
      cat = "bat";
      diff = "diff --color=auto";
      ip = "ip --color=auto";
      ln = "ln -nv";
      chmod = "chmod -c";
      chown = "chown -c";
      chattr = "chattr -V";
      md = "mkdir";
      zr = "z $(ghq list -p | fzf)";
      gc = "git commit";
      gp = "git push";
      gd = "git diff";
      gs = "git status";
      ga = "git add";
      gl = "git pull";
      oct = "stat -c '%A %a %n'";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initContent = builtins.readFile ./zshrc;
  };
  programs.fzf = {
    enable = true;
    colors = {
      fg = "#D8DEE9";
      bg = "#2E3440";
      hl = "#A3BE8C";
      "fg+" = "#D8DEE9";
      "bg+" = "#434C5E";
      "hl+" = "#A3BE8C";
      pointer = "#BF616A";
      info = "#4C566A";
      spinner = "#4C566A";
      header = "#4C566A";
      prompt = "#81A1C1";
      marker = "#EBCB8B";
    };
  };
  programs.zoxide.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$nix_shell"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      character = {
        success_symbol = "😼";
        error_symbol = "😿";
      };
    };
  };
}
