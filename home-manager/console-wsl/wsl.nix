{
  # $ dpkg-reconfigure locales
  # select en_US.UTF-8
  home.sessionVariables = {
    BROWSER = "/mnt/c/Program\\ Files/Mozilla\\ Firefox/firefox.exe";
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
