{
  config,
  lib,
  pkgs,
  isNixOS,
  ...
}:

let
  cfg = config.programs.zsh;
  dircolorsPath =
    if config.home.preferXdgDirectories then
      "${config.xdg.configFile."dir_colors".source}"
    else
      "${config.home.file.".dir_colors".source}";
  dircolors = builtins.readFile (
    pkgs.runCommand "dircolors" { } "${pkgs.coreutils}/bin/dircolors -b ${dircolorsPath} > $out"
  );
  zoxide = pkgs.runCommand "zoxide" { } "${pkgs.zoxide}/bin/zoxide init zsh > $out";
  starship = pkgs.runCommand "starship" { } "${pkgs.starship}/bin/starship init zsh > $out";
  fzf = pkgs.runCommand "fzf" { } "${pkgs.fzf}/bin/fzf --zsh > $out";
  relToDotDir = file: (lib.optionalString (cfg.dotDir != null) (cfg.dotDir + "/")) + file;
  zshBin = if isNixOS then "${pkgs.zsh}/bin/zsh" else "/bin/zsh";
in
{

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
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
      LANG = "en_US.UTF-8";

    };
    sessionVariables = rec {
      LESS = "-FRi";
      BROWSER = "xdg-open";
      BAT_PAGER = "less ${LESS}";

    };
    shellAliases = {
      le = "less";
      rg = "batgrep";
      man = "batman -L ja_JP.UTF-8";
      cd = "z";
      gksu = "pkexec env WAYLAND_DISPLAY=$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY XDG_RUNTIME_DIR=/run/user/0 DISPLAY=$DISPLAY";
      npm = "pnpm";
      cz = "git cz";
      nix-shell = "nix-shell --command ${zshBin}";
      rm = "rip";
      # lg = "lazygit";
      ll = "eza -F -oalg --time-style=long-iso --color=always";
      ls = "eza -F --time-style=long-iso --color=always";
      l = "ls";
      la = "eza -F -a --time-style=long-iso --color=always";
      tree = "eza -T --time-style=long-iso --color=always";
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
      lg = "lazygit";
    };
    # zprof.enable = true;
    setOptions = [
      "correct"
      "interactivecomments"
      "no_beep"
    ];
    initContent = lib.mkMerge [
      ''
        source ${config.xdg.cacheHome}/sheldon.zsh
        ${dircolors}
      ''
      (lib.mkAfter (builtins.readFile ./zshrc))
    ];
  };

  home.activation.zshScripts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for file in \
      ${relToDotDir ".zshrc"} \
      ${relToDotDir ".zshenv"} \
      $HOME/.config/sheldon/*/*.zsh
    do
      if [ ! -f "$file.zwc" ]; then
        ${zshBin} -c "zcompile '$file'"
      fi
    done

    sheldon_cache=${config.xdg.cacheHome}/sheldon.zsh
    [ ! -f "$sheldon_cache" ] && ${pkgs.sheldon}/bin/sheldon source > "$sheldon_cache"
    if [ ! -f "$sheldon_cache.zwc" ]; then
      ${zshBin} -c "zcompile -R '$sheldon_cache'"
    fi
  '';

  home.file."${relToDotDir ".zshrc"}".onChange = "${zshBin} -c 'zcompile ~/.zshrc'";
  home.file."${relToDotDir ".zshenv"}".onChange = "${zshBin} -c 'zcompile ~/.zshenv'";
  home.packages = [ pkgs.sheldon ];

  xdg.configFile."sheldon/sync/starship.zsh" = {
    source = starship;
    onChange = "${zshBin} -c 'zcompile ${config.xdg.configHome}/sheldon/sync/starship.zsh'";
  };

  xdg.configFile."sheldon/async/fzf.zsh" = {
    source = fzf;
    onChange = "${zshBin} -c 'zcompile ${config.xdg.configHome}/sheldon/async/fzf.zsh'";
  };

  xdg.configFile."sheldon/async/zoxide.zsh" = {
    source = zoxide;
    onChange = "${zshBin} -c 'zcompile ${config.xdg.configHome}/sheldon/async/zoxide.zsh'";
  };

  xdg.configFile."sheldon/async/command-not-found.zsh" = {
    source = "${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh";
    onChange = "${zshBin} -c 'zcompile ${config.xdg.configHome}/sheldon/async/command-not-found.zsh'";
  };

  xdg.configFile."sheldon/plugins.toml" = {
    onChange = ''
      sheldon_cache=${config.xdg.cacheHome}/sheldon.zsh
      ${pkgs.sheldon}/bin/sheldon source --update &>/dev/null > "$sheldon_cache"
      ${zshBin} -c "zcompile '$sheldon_cache'"
    '';
    text = ''
      shell = "zsh"

      [templates]
      defer = """{% for file in files %}zsh-defer source "{{ file }}"\n{% endfor %}"""

      [plugins.zsh-defer]
      github = "romkatv/zsh-defer"

      [plugins.zsh-autopair]
      github = "hlissner/zsh-autopair"
      apply = ["defer"]

      [plugins.starship]
      inline = "source ~/.config/sheldon/sync/starship.zsh"

      [plugins.zoxide]
      inline = "zsh-defer source ~/.config/sheldon/async/zoxide.zsh"

      [plugins.compinit]
      inline = """
      autoload -U compinit && zsh-defer compinit
      zsh-defer compdef _rg batgrep
      zsh-defer compdef _man batman
      """

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
