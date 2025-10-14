{
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:
{
  programs.dircolors = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      OTHER_WRITABLE = "30;46";
    };
  };

  programs.zsh = {
    enable = true;
    package = lib.mkIf (!isNixOS) pkgs.emptyDirectory;
    completionInit = "";
    defaultKeymap = "emacs";
    autocd = true;
    localVariables = {
      WORDCHARS = "*?_[]~&!$%^(){}<>";
    };
    sessionVariables = {
      LANG = "en_US.UTF-8";
    };
    shellAliases = {
      cd = "z";
      gksu = "pkexec env WAYLAND_DISPLAY=$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY XDG_RUNTIME_DIR=/run/user/0 DISPLAY=$DISPLAY";
      npm = "pnpm";
      cz = "git cz";
      nix-shell = "nix-shell --command $(command -v zsh)";
      rm = "rip";
      lg = "lazygit";
      ll = "eza -F -oalg --time-style=long-iso";
      ls = "eza -F --time-style=long-iso";
      l = "ls";
      la = "eza -F -a --time-style=long-iso";
      tree = "eza -T --time-style=long-iso";
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
    # zprof.enable = true;
    initContent =
      let
        dircolors = builtins.readFile (
          pkgs.runCommandNoCCLocal "dircolors" { }
            "${pkgs.coreutils}/bin/dircolors -b ${config.home.file.".dir_colors".source} > $out"
        );
        zoxide = pkgs.runCommandNoCCLocal "zoxide" { } "${pkgs.zoxide}/bin/zoxide init zsh > $out";
        starship = pkgs.runCommandNoCCLocal "starship" { } "${pkgs.starship}/bin/starship init zsh > $out";
      in
      ''
        source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh
        source ${starship}
        zsh-defer source ${pkgs.fzf}/share/fzf/key-bindings.zsh
        ${dircolors}
        zsh-defer source ${zoxide}
        autoload -U compinit &&  zsh-defer compinit
        source ${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh
        zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ''
      + builtins.readFile ./zshrc;

  };

}
