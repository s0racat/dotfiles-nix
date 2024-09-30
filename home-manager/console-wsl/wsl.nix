{ ... }:
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
    package = null;
    profileExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then source ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
    shellAliases = {
      ssh = "ssh.exe";
      ssh-add = "ssh-add.exe";
    };
  };

}
