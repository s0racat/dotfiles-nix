{
  pkgs,
  lib,
  config,
  ...
}:
let
  winexe =
    path: pkgs.writeShellScriptBin (builtins.baseNameOf path) ''${lib.escapeShellArg path} $@'';
  winExes = paths: builtins.map winexe paths;
in
{
  # wslpath 'C:\...'
  # $ dpkg-reconfigure locales
  # select en_US.UTF-8
  home.packages = [
    (pkgs.writeShellScriptBin "clip.exe" ''${pkgs.iconv}/bin/iconv -t utf16le | ${lib.escapeShellArg "/mnt/c/Windows/System32/clip.exe"} $@'')
  ]
  ++ winExes [
    "/mnt/c/Windows/explorer.exe"
    "/mnt/c/Windows/System32/rundll32.exe"
    "/mnt/c/Program Files/GitHub CLI/gh.exe"
    "/mnt/c/Program Files/OpenSSH/ssh.exe"
    "/mnt/c/Program Files/OpenSSH/ssh-add.exe"
    "/mnt/c/Users/${config.home.username}/AppData/Local/Programs/Microsoft VS Code/bin/code"
    "/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
  ];
  home.sessionVariables = {
    WIN_HOME = "/mnt/c/Users/${config.home.username}";
  };
  programs.git = {
    extraConfig = {
      core.sshcommand = "ssh.exe";
    };
  };
  programs.zsh = {
    sessionVariables = {
      GH_TOKEN = "$(gh.exe auth token)";
    };
    shellAliases = {
      ssh = "ssh.exe";
      ssh-add = "ssh-add.exe";
      code = "code";
      firefox = "firefox.exe";
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
