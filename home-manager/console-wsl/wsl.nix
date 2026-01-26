{
  pkgs,
  lib,
  config,
  ...
}:
let

  winExes =
    let
      winexe =
        path:
        let
          base = builtins.baseNameOf path;
          name = if lib.hasSuffix ".exe" base then base else "${base}.exe";
        in
        pkgs.writeShellScriptBin name ''
          ${lib.escapeShellArg path} "$@"
        '';
    in
    paths: builtins.map winexe paths;

in
{
  # wslpath 'C:\...'
  # $ dpkg-reconfigure locales
  # select en_US.UTF-8, ja_JP.UTF-8
  home.packages = [
    pkgs.win32yank
  ]
  ++ winExes [
    "/mnt/c/Windows/explorer.exe"
    "/mnt/c/Windows/System32/rundll32.exe"
    "/mnt/c/Program Files/GitHub CLI/gh.exe"
    "/mnt/c/Program Files/OpenSSH/ssh-add.exe"
    "/mnt/c/Program Files/OpenSSH/ssh.exe"
    "/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
    "/mnt/c/Users/${config.home.username}/AppData/Local/Programs/Microsoft VS Code/bin/code"
    "/mnt/c/Program Files/Docker/Docker/resources/bin/docker-credential-wincred.exe" # ~/.docker/config.json: { "credsStore": "wincred.exe" }
  ];
  programs.docker-cli = {
    enable = true;
    settings = {
      credsStore = "wincred.exe";
    };
  };
  home.sessionVariables = {
    WIN_HOME = "/mnt/c/Users/${config.home.username}";
  };
  programs.git = {
    settings = {
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
      clip = "win32yank.exe -i --crlf";
    };
    initContent = lib.mkAfter ''
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
