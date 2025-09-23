{ ... }:
{
  # $ dpkg-reconfigure locales
  # select en_US.UTF-8
  home.sessionVariables = {
    GH_TOKEN = "$(gh.exe auth token)";
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
