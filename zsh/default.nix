{ lib, isWSL, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "exa -F -alg --time-style=long-iso";
      ls = "exa -F --time-style=long-iso";
      l = "ls";
      la = "exa -F -a --time-style=long-iso";
      tree = "exa -T --time-style=long-iso";
      cp = "cp -v";
      mv = "mv -v";
      rm = "rm -vi";
      mkdir = "mkdir -vp";
      vim = "nvim";
      vi = "nvim";
      cat = "bat";
      diff = "diff --color=auto";
      ip = "ip --color=auto";
      ln = "ln -nv";
      chmod = "chmod -c";
      chown = "chown -c";
      chattr = "chattr -V";
      oct = "stat -c '%A %a %n'";
      md = "mkdir";
      cdr = "cd $(ghq list -p | fzf)";


    } // lib.optionalAttrs isWSL {
      ssh = "ssh.exe";
      ssh-add = "ssh-add.exe";
    };


    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    autocd = true;

    profileExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then source ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
      if [ -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then source ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi
    '';
    initExtra = (builtins.readFile ./zshrc.extra);
    defaultKeymap = "emacs";
  };
  programs.starship.enable = true;
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
}