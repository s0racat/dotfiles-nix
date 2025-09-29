{
  pkgs,
  lib,
  config,
  ...
}:
let
  winexe =
    path:
    toString (
      pkgs.writeShellScript (builtins.replaceStrings [ "." ] [ "_" ] (
        builtins.baseNameOf path
      )) ''${lib.escapeShellArg path} $@''
    );
in
{
  # wslpath 'C:\...'
  # $ dpkg-reconfigure locales
  # select en_US.UTF-8
  home.sessionVariables = {
    GH_TOKEN = "$(${winexe "/mnt/c/Program Files/GitHub CLI/gh.exe"} auth token)";
    WIN_HOME = "/mnt/c/Users/${config.home.username}";
  };
  programs.git = {
    extraConfig = {
      core.sshcommand = winexe "/mnt/c/Program Files/OpenSSH/ssh.exe";
    };
  };
  programs.zsh = {
    shellAliases = {
      ssh = winexe "/mnt/c/Program Files/OpenSSH/ssh.exe";
      ssh-add = winexe "/mnt/c/Program Files/OpenSSH/ssh-add.exe";
      code = winexe "/mnt/c/Users/takumi/AppData/Local/Programs/Microsoft VS Code/bin/code";
      explorer = winexe "/mnt/c/Windows/explorer.exe";
      firefox = winexe "/mnt/c/Program Files/Mozilla Firefox/firefox.exe";
    };
    initContent = ''
      wwhich() {
        /mnt/c/Windows/System32/where.exe "$1" 2>/dev/null |
          sed 's/\r$//' |
          while read -r line; do
            wslpath "$line"
          done
      }
    '';

  };
}
