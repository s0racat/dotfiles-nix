{
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:

let
  dircolors = builtins.readFile (
    pkgs.runCommandNoCC "dircolors" { }
      "${pkgs.coreutils}/bin/dircolors -b ${config.home.file.".dir_colors".source} > $out"
  );
  zoxide = pkgs.runCommandNoCC "zoxide" { } "${pkgs.zoxide}/bin/zoxide init zsh > $out";
  starship = pkgs.runCommandNoCC "starship" { } "${pkgs.starship}/bin/starship init zsh > $out";
  fzf = pkgs.runCommandNoCC "fzf" { } "${pkgs.fzf}/bin/fzf --zsh > $out";
  cfg = config.programs.zsh;
  relToDotDir = file: (lib.optionalString (cfg.dotDir != null) (cfg.dotDir + "/")) + file;
  zshBin = if isNixOS then "${pkgs.zsh}/bin/zsh" else "/bin/zsh";
in
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
      nix-shell = "nix-shell --command ${zshBin}";
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
    setOptions = [
      "correct"
      "interactivecomments"
      "no_beep"
    ];
    initContent = ''
      source ${config.xdg.cacheHome}/sheldon.zsh
      ${dircolors}
    ''
    + builtins.readFile ./zshrc;

  };

  home.activation.zshScripts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for file in \
      ${relToDotDir ".zshrc"} \
      ${relToDotDir ".zshenv"} \
      $HOME/.config/sheldon/sync/starship.zsh \
      $HOME/.config/sheldon/async/fzf.zsh \
      $HOME/.config/sheldon/async/zoxide.zsh \
      $HOME/.config/sheldon/async/command-not-found.zsh
    do
      if [ -f "$file" ] && { [ ! -f "$file.zwc" ] || [ "$file" -nt "$file.zwc" ]; }; then
        ${zshBin} -c "zcompile '$file'"
      fi
    done

    # sheldon plugins.toml 更新
    sheldon_cache=${config.xdg.cacheHome}/sheldon.zsh
    [ ! -f "$sheldon_cache" ] && ${pkgs.sheldon}/bin/sheldon source --update &>/dev/null > "$sheldon_cache"
    if [ ! -f "${config.xdg.cacheHome}/sheldon.zsh.zwc" ] || [ "${config.xdg.cacheHome}/sheldon.zsh" -nt "${config.xdg.cacheHome}/sheldon.zsh.zwc" ]; then
      ${zshBin} -c "zcompile -R '${config.xdg.cacheHome}/sheldon.zsh'"
    fi
  '';

  home.packages = [ pkgs.sheldon ];

  xdg.configFile."sheldon/sync/starship.zsh" = {
    source = starship;
  };

  xdg.configFile."sheldon/async/fzf.zsh" = {
    source = fzf;
  };

  xdg.configFile."sheldon/async/zoxide.zsh" = {
    source = zoxide;
  };

  xdg.configFile."sheldon/async/command-not-found.zsh" = {
    source = "${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh";
  };

  xdg.configFile."sheldon/plugins.toml" = {
    onChange = ''
      ${pkgs.sheldon}/bin/sheldon source --update &>/dev/null > "${config.xdg.cacheHome}/sheldon.zsh"
    '';
    text = ''
      shell = "zsh"

      [templates]
      defer = """{% for file in files %}zsh-defer source "{{ file }}"\n{% endfor %}"""

      [plugins.zsh-defer]
      github = "romkatv/zsh-defer"

      [plugins.starship]
      inline = "source ~/.config/sheldon/sync/starship.zsh"

      [plugins.zoxide]
      inline = "zsh-defer source ~/.config/sheldon/async/zoxide.zsh"

      [plugins.compinit]
      inline = "autoload -U compinit && zsh-defer compinit"

      [plugins.fzf]
      inline = "zsh-defer source ~/.config/sheldon/async/fzf.zsh"

      [plugins.command-not-found]
      inline = "zsh-defer source ~/.config/sheldon/async/command-not-found.zsh"

      [plugins.zsh-autosuggestions]
      apply = ["defer"]
      github = "zsh-users/zsh-autosuggestions"

      [plugins.zsh-syntax-highlighting]
      apply = ["defer"]
      github = "zsh-users/zsh-syntax-highlighting"
    '';
  };

}
