{ config,... }:
{
  home.sessionVariables = {
    BROWSER = "/mnt/c/Program\\ Files/Mozilla\\ Firefox/firefox.exe";
  };
  programs.git = {
    extraConfig = {
      core.sshcommand = "ssh.exe";
    };
  };
  programs.zsh = {
    profileExtra = with config.home;''
      if [ -e ${profileDirectory}/etc/profile.d/nix.sh ]; then source ${profileDirectory}/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
    shellAliases = {
      ssh = "ssh.exe";
      ssh-add = "ssh-add.exe";
    };
  };

}
