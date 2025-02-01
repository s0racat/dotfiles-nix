{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "firefox";
      text = ''
        /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe "$@"
      '';
    })
  ];
  # $ dpkg-reconfigure locales
  # select en_US.UTF-8
  home.sessionVariables = {
    BROWSER = "firefox";
  };
  programs.git = {
    extraConfig = {
      core.sshcommand = "ssh.exe";
    };
  };
  programs.zsh = {
    shellAliases = {
      ssh = "ssh.exe";
      ssh-add = "ssh-add.exe";
    };
  };
}
